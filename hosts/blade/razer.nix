# Razer Blade 14 (2021, RZ09-0370): Ryzen 9 5900HX + RTX 3070 Mobile.
# Everything Razer-specific lives here.
{ pkgs, lib, ... }:

let
  # Headphone amp + headset mic fix for the Realtek ALC897 (subsystem 1a58:2014).
  # [pincfg]: declare pin 0x19 as the combo-jack mic (firmware marks it unconnected).
  # [verb]:   GPIO 0-2 mask/direction/data high to switch on the external headphone amp.
  # Loaded by the HDA patch loader; codecs that don't match the [codec] line ignore it.
  hpAmpFw = "razer-blade14-2021-hp-amp.fw";
  hpAmpFirmware =
    pkgs.writeTextFile {
      name = "razer-blade14-2021-hp-amp";
      destination = "/lib/firmware/${hpAmpFw}";
      text = ''
        [codec]
        0x10ec0897 0x1a582014 0

        [pincfg]
        0x19 0x03a1113c

        [verb]
        0x01 0x716 0x07
        0x01 0x717 0x07
        0x01 0x715 0x07
      '';
    }
    # Keep the file uncompressed so the patch loader finds it under its plain name.
    // {
      compressFirmware = false;
    };
in
{
  # R3: headphone jack and headset mic
  hardware.firmware = [ hpAmpFirmware ];
  boot.extraModprobeConfig = ''
    options snd-hda-intel patch=${hpAmpFw},${hpAmpFw},${hpAmpFw}
  '';

  # R4: AMD iGPU + NVIDIA dGPU in PRIME offload mode
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu.initrd.enable = true;
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # lspci 0000:04:00.0 / 0000:01:00.0, in decimal
      amdgpuBusId = "PCI:4:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # R5: firmware and radios (Intel AX210 Wi-Fi/Bluetooth, amdgpu)
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;

  # R6: keyboard/logo lighting (1532:0270)
  hardware.openrazer = {
    enable = true;
    users = [ "kaleb" ];
  };

  environment.systemPackages = with pkgs; [
    alsa-tools # hda-verb, for checking the headphone fix
    pciutils
    nvtopPackages.full
    powertop
  ];
}
