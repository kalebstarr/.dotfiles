{ pkgs, ... }:

{
  home.packages = with pkgs; [
    whisper-cpp
    piper-tts
  ];
}
