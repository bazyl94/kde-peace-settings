/*
 * Copyright 2015  Martin Kotelnik <clearmartin@seznam.cz>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */
import QtQuick 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: main
    
    property bool vertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    
//     property double horizontalScreenWidthPercent: plasmoid.configuration.horizontalScreenWidthPercent
    property double buttonSize: plasmoid.configuration.buttonSize
    
    anchors.fill: parent
    Layout.preferredWidth: (parent.width <= 1024) ? 32*plasmoid.configuration.buttonSize : 64*plasmoid.configuration.buttonSize
    
    //vertical ? parent.width : Screen.width * horizontalScreenWidthPercent //3*plasmoid.configuration.buttonSize + 60 //
    Layout.minimumWidth: Layout.preferredWidth
    Layout.maximumWidth: Layout.preferredWidth
    Layout.preferredHeight:  parent.height //vertical ? Math.min(theme.defaultFont.pointSize * 4, parent.width) :
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight
    
    property bool noWindowVisible: false
    property int controlButtonsSpacing: 10
    
    property int bp: plasmoid.configuration.buttonsPosition;
    property bool showControlButtons: plasmoid.configuration.showControlButtons
//     property bool showMinimize: showControlButtons && plasmoid.configuration.showMinimize
    property bool doubleClickMinimizes: plasmoid.configuration.doubleClickMinimizes
    property bool middleClickFullscreen: plasmoid.configuration.middleClickFullscreen
    property bool wheelUpMaximizes: plasmoid.configuration.wheelUpMaximizes
    property bool wheelDownMinimizes: plasmoid.configuration.wheelDownAction === 1
    property bool wheelDownUnmaximizes: plasmoid.configuration.wheelDownAction === 2
    
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    //
    // MODEL
    //
    PlasmaCore.DataSource {
        id: tasksSource
        engine: 'tasks'
        onSourceAdded: {
            connectSource(source);
        }
        connectedSources: 'tasks'
    }
    // should return always one item
    PlasmaCore.SortFilterModel {
        id: activeWindowModel
        filterRole: 'Active'
        filterRegExp: 'true'
        sourceModel: tasksSource.models.tasks
        onCountChanged: {
            noWindowVisible = count === 0
        }
    }
    
    function toggleMaximized() {
        var service = tasksSource.serviceForSource('tasks')
        var operation = service.operationDescription('toggleMaximized')
        operation.Id = tasksSource.models.tasks.activeTaskId()
        service.startOperationCall(operation)
    }
    function toggleMinimized() {
        var service = tasksSource.serviceForSource('tasks')
        var operation = service.operationDescription('toggleMinimized')
        operation.Id = tasksSource.models.tasks.activeTaskId()
        service.startOperationCall(operation)
    }
    
    function toggleFullscreen() {
        var service = tasksSource.serviceForSource('tasks')
        var operation = service.operationDescription('toggleFullScreen')
        operation.Id = tasksSource.models.tasks.activeTaskId()
        service.startOperationCall(operation)
    }
    
    function setMaximized(maximized) {
        var service = tasksSource.serviceForSource('tasks')
        var operation = service.operationDescription('setMaximized')
        operation.Id = tasksSource.models.tasks.activeTaskId()
        operation.maximized = maximized
        service.startOperationCall(operation)
    }
    
    function setMinimized() {
        var service = tasksSource.serviceForSource('tasks')
        var operation = service.operationDescription('setMinimized')
        operation.Id = tasksSource.models.tasks.activeTaskId()
        operation.minimized = true
        service.startOperationCall(operation)
    }
    
//     Text {
//         id: noWindowText
//         anchors.verticalCenter: parent.verticalCenter
//         anchors.leftMargin: 10
//         anchors.left: parent.left
//         text: i18n('kwin5 buttons')
//         color: theme.textColor
//         width: parent.width - 10
//         elide: Text.ElideRight
//         
//         visible: noWindowVisible
//     }

    //
    // ACTIVE WINDOW INFO
    //
//     ListView {
//         id: activeWindowListView
//         anchors.fill: parent
//         width: parent.width
//         
//         model: activeWindowModel
//         
//         delegate: Item {
//             width: parent.width
//             height: main.height
//             
//             // window icon
//             PlasmaCore.IconItem {
//                 id: iconItem
//                 
//                 width: parent.height
//                 height: parent.height
//                 
//                 source: DecorationRole
//             }
//             
//             // window title
//             Text {
//                 id: windowTitleText
//                 anchors {
//                     left: iconItem.right
//                     verticalCenter: parent.verticalCenter
//                 }
//                 text: DisplayRole
//                 color: theme.textColor
//                 wrapMode: Text.WordWrap
//                 maximumLineCount: parent.height / 20
//                 width: parent.width - iconItem.width
//                 elide: Text.ElideRight
//             }
//         }
//     }

    MouseArea {
        anchors.fill: parent
        
        hoverEnabled: true
        
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        
        onEntered: {
            controlButtonsArea.mouseInWidget = true //showControlButtons  //&& !noWindowVisible
        }
        
        onExited: {
            controlButtonsArea.mouseInWidget = true //false
        }
        
        onWheel: {
            if (wheel.angleDelta.y > 0) {
                if (wheelUpMaximizes) {
                    setMaximized(true)
                }
            } else {
                if (wheelDownMinimizes) {
                    setMinimized()
                } else if (wheelDownUnmaximizes) {
                    setMaximized(false)
                }
            }
        }
        
        onDoubleClicked: {
            if (mouse.button == Qt.LeftButton && doubleClickMinimizes) {
                toggleMinimized()
            }
        }
        
        onClicked: {
            if (mouse.button == Qt.MiddleButton && middleClickFullscreen) {
                toggleFullscreen()
            }
        }
        
    }
    
    Item {
        id: controlButtonsArea
        
        visible: showControlButtons

        height: parent.height * buttonSize
        width:  height  // + (showMinimize ? height + controlButtonsSpacing : 0)
        
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        
        property bool mouseInWidget: true
        property bool mouseInside: true //mouseInWidget || closeButton.mouseInside || minimizeButton.mouseInside || maximizeButton.mouseInside
        

        
        ControlButton {
            id: minimizeButton
            iconElementId: 'remove'
            windowOperation: 'toggleMinimized'
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
//             anchors.right: parent.right; anchors.rightMargin: 0
            
            
            visible: true
        }
//         ControlButton {
//             id: maximizeButton
//             iconElementId: 'maximize'
//             windowOperation: 'toggleMaximized'
//             
// 
//             anchors.left: minimizeButton.right; anchors.leftMargin: 5
// //             anchors.right: minimizeButton.left +20
//             
//             visible: true//showMinimize
//         }
//         ControlButton {
//             id: closeButton
//             iconElementId: 'close'
//             windowOperation: 'close'
//             
//             anchors.left: maximizeButton.right; anchors.leftMargin: 5
//             anchors.right : parent.rightMargin
//             visible: true
//         }
    }
    
}
 