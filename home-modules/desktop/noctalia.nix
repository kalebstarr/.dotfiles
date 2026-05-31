{ lib, pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      quickshell
    ]
    ++ lib.optionals (pkgs ? noctalia-shell) [
      pkgs.noctalia-shell
    ];

  xdg.configFile."quickshell/noctalia/shell.qml".text = ''
    import Quickshell
    import QtQuick

    ShellRoot {
        PanelWindow {
            id: bar

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 32
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: "#1e1e2e"

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 12

                    Text {
                        color: "#cdd6f4"
                        text: "niri"
                        font.family: "FiraCode Nerd Font"
                        font.pixelSize: 13
                    }
                }

                Text {
                    id: clock

                    anchors.centerIn: parent
                    color: "#cdd6f4"
                    font.family: "FiraCode Nerd Font"
                    font.pixelSize: 13

                    function updateTime() {
                        text = Qt.formatDateTime(new Date(), "hh:mm")
                    }

                    Component.onCompleted: updateTime()
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clock.updateTime()
                }
            }
        }
    }
  '';
}
