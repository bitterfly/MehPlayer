=begin
** Form generated from reading ui file 'listwindow.ui'
**
** Created: Fri Jan 30 20:38:17 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_ListWindow
    attr_reader :centralwidget
    attr_reader :verticalLayout
    attr_reader :song_list

    def setupUi(listWindow)
    if listWindow.objectName.nil?
        listWindow.objectName = "listWindow"
    end
    listWindow.resize(434, 521)
    @centralwidget = Qt::Widget.new(listWindow)
    @centralwidget.objectName = "centralwidget"
    @verticalLayout = Qt::VBoxLayout.new(@centralwidget)
    @verticalLayout.objectName = "verticalLayout"
    @song_list = Qt::ListWidget.new(@centralwidget)
    @song_list.objectName = "song_list"

    @verticalLayout.addWidget(@song_list)

    listWindow.centralWidget = @centralwidget

    retranslateUi(listWindow)

    Qt::MetaObject.connectSlotsByName(listWindow)
    end # setupUi

    def setup_ui(listWindow)
        setupUi(listWindow)
    end

    def retranslateUi(listWindow)
    listWindow.windowTitle = Qt::Application.translate("ListWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(listWindow)
        retranslateUi(listWindow)
    end

end

module Ui
    class ListWindow < Ui_ListWindow
    end
end  # module Ui

