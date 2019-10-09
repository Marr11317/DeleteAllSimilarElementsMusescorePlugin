import QtQuick 2.0
import MuseScore 3.0
import QtQuick.Dialogs 1.1

MuseScore {
      menuPath: "Plugins.DeleteAllSimilarElements"
      description: "This plugin deletes all similar elements in a score: select a single element and launch it (I like the shortcut ctrl+shift+delete)."
      version: "1.0"
      requiresScore: true
      onRun: {
            if (!curScore)
                  Qt.quit();
            
            if ((mscoreMajorVersion < 3) || (mscoreMinorVersion < 3)) {
                  versionError.open();
                  Qt.quit();
            } else if (curScore.selection.elements.length == 0) {
                  selectionError.open();
                  Qt.quit();
            } else {
                  curScore.startCmd();
                  cmd("select-similar");
                  cmd("delete");
                  curScore.endCmd();
                  Qt.quit();
            }
      }
      MessageDialog {
            id: versionError
            visible: false
            title: qsTr("Unsupported MuseScore version")
            text: qsTr("This plugin needs MuseScore 3.3 or later.")
            onAccepted: {
                  Qt.quit()
            }
      }
      MessageDialog {
            id: selectionError
            visible: false
            title: qsTr("Plugin selection error")
            text: qsTr("Please select at least one element before running this plugin.")
            onAccepted: {
                  Qt.quit()
            }
      }
} // MuseScore
