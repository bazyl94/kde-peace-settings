import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    id: appearancePage

    property alias cfg_showControlButtons: showControlButtons.checked
    property alias cfg_doNotHideControlButtons: doNotHideControlButtons.checked
    property int cfg_buttonsPosition
    property alias cfg_buttonsVerticalCenter: buttonsVerticalCenter.checked
    property alias cfg_buttonsStandalone: buttonsStandalone.checked
    property alias cfg_buttonsDynamicWidth: buttonsDynamicWidth.checked
    property alias cfg_slidingIconAndText: slidingIconAndText.checked
    property alias cfg_showButtonOnlyWhenMaximized: showButtonOnlyWhenMaximized.checked
    property alias cfg_showClose: showClose.checked
    property alias cfg_showMinimize: showMinimize.checked
    property alias cfg_showMaximize: showMaximize.checked
    property alias cfg_showPinToAllDesktops: showPinToAllDesktops.checked
    property alias cfg_buttonSize: buttonSize.value
    property alias cfg_controlButtonsSpacing: controlButtonsSpacing.value

    onCfg_buttonsPositionChanged: {
        switch (cfg_buttonsPosition) {
        case 0:
            buttonsPositionGroup.current = upperLeftRadio;
            break;
        case 1:
            buttonsPositionGroup.current = upperRightRadio;
            break;
        case 2:
            buttonsPositionGroup.current = bottomLeftRadio;
            break;
        case 3:
            buttonsPositionGroup.current = bottomRightRadio;
            break;
        default:
            buttonsPositionGroup.current = upperLeftRadio;
        }
    }

    Component.onCompleted: {
        cfg_buttonsPositionChanged()
    }

    ExclusiveGroup {
        id: buttonsPositionGroup
    }

    GroupBox {
        id: showControlButtons
        title: i18n("Enable Control Buttons")
        checkable: true
        flat: true

        GridLayout {
            columns: 2

            Item {
                width: 2
                height: 10
                Layout.columnSpan: 2
            }

            Item {
                width: 2
                height: 2
                Layout.rowSpan: 5
            }
            
            CheckBox {
                id: showClose
                text: i18n("Show close button")
            }
            
            CheckBox {
                id: showMinimize
                text: i18n("Show minimize button")
            }

            CheckBox {
                id: showMaximize
                text: i18n("Show maximize button")
            }

            CheckBox {
                id: showPinToAllDesktops
                text: i18n("Show pin to all desktops")
            }
            
            Label {
                    text: i18n('Buttons Order:')
                    Layout.alignment: Qt.AlignLeft
                }
                
            ComboBox {
                    id: buttonsOrder
                    model: [i18n('mMX'), i18n('mXM'), i18n('MmX'), i18n('MXm'), i18n('XmM'), i18n('XMm')]
                }
                
            Item {
                width: 2
                height: 10
                Layout.columnSpan: 2
            }

            Label {
                text: i18n("Behaviour:")
                Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
            }

            CheckBox {
                id: doNotHideControlButtons
                text: i18n("Do not hide on mouse out")
            }

            Item {
                width: 2
                height: 2
                Layout.rowSpan: 4
            }

            CheckBox {
                id: showButtonOnlyWhenMaximized
                text: i18n("Show only when maximized")
            }

            CheckBox {
                id: buttonsStandalone
                text: i18n("Buttons next to icon and text")
            }

            CheckBox {
                id: buttonsDynamicWidth
                text: i18n("Dynamic width")
                enabled: buttonsStandalone.checked
            }

            CheckBox {
                id: slidingIconAndText
                text: i18n("Sliding icon and text")
                enabled: buttonsStandalone.checked
            }


            Item {
                width: 2
                height: 10
                Layout.columnSpan: 2
            }

            Label {
                text: i18n("Position:")
                Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
            }
            RadioButton {
                id: upperLeftRadio
                exclusiveGroup: buttonsPositionGroup
                text: i18n("Upper left")
                onCheckedChanged: if (checked) cfg_buttonsPosition = 0;
            }
            Item {
                width: 2
                height: 2
                Layout.rowSpan: 4
            }
            RadioButton {
                id: upperRightRadio
                exclusiveGroup: buttonsPositionGroup
                text: i18n("Upper right")
                onCheckedChanged: if (checked) cfg_buttonsPosition = 1;
            }
            RadioButton {
                id: bottomLeftRadio
                exclusiveGroup: buttonsPositionGroup
                text: i18n("Bottom left")
                onCheckedChanged: if (checked) cfg_buttonsPosition = 2;
            }
            RadioButton {
                id: bottomRightRadio
                exclusiveGroup: buttonsPositionGroup
                text: i18n("Bottom right")
                onCheckedChanged: if (checked) cfg_buttonsPosition = 3;
            }

            CheckBox {
                id: buttonsVerticalCenter
                text: i18n("Vertical center")
            }

            Item {
                width: 2
                height: 10
                Layout.columnSpan: 2
            }

            Label {
                text: i18n("Button size:")
                Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
            }
            Slider {
                id: buttonSize
                stepSize: 0.1
                minimumValue: 0.1
                tickmarksEnabled: true
                width: parent.width
            }

            Label {
                text: i18n("Buttons spacing:")
                Layout.alignment: Qt.AlignVCenter|Qt.AlignLeft
            }
            Slider {
                id: controlButtonsSpacing
                stepSize: 1
                minimumValue: 0
                maximumValue: 20
                tickmarksEnabled: true
                width: parent.width
            }
        }
    }


}
