=begin
** Form generated from reading ui file 'listwindow.ui'
**
** Created: Wed Feb 4 22:40:22 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_ListWindow
    attr_reader :centralwidget
    attr_reader :verticalLayout
    attr_reader :horizontalLayout
    attr_reader :enqueue_folder
    attr_reader :enqueue_file
    attr_reader :remove
    attr_reader :delete_all
    attr_reader :verticalLayout_3
    attr_reader :horizontalLayout_2
    attr_reader :sort_by_author
    attr_reader :sort_by_title
    attr_reader :verticalLayout_2
    attr_reader :song_list
    attr_reader :label
    attr_reader :search

    def setupUi(listWindow)
    if listWindow.objectName.nil?
        listWindow.objectName = "listWindow"
    end
    listWindow.resize(434, 521)
    listWindow.styleSheet = ""
    listWindow.tabShape = Qt::TabWidget::Rounded
    listWindow.dockNestingEnabled = false
    @centralwidget = Qt::Widget.new(listWindow)
    @centralwidget.objectName = "centralwidget"
    @verticalLayout = Qt::VBoxLayout.new(@centralwidget)
    @verticalLayout.objectName = "verticalLayout"
    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.objectName = "horizontalLayout"
    @enqueue_folder = Qt::PushButton.new(@centralwidget)
    @enqueue_folder.objectName = "enqueue_folder"
    @enqueue_folder.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"color: rgb(255,255,255);\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout.addWidget(@enqueue_folder)

    @enqueue_file = Qt::PushButton.new(@centralwidget)
    @enqueue_file.objectName = "enqueue_file"
    @enqueue_file.styleSheet = "font: 75 9pt \"NanumGothic\";\n" \
"color: rgb(255,255,255);\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout.addWidget(@enqueue_file)

    @remove = Qt::PushButton.new(@centralwidget)
    @remove.objectName = "remove"
    @remove.styleSheet = "font: 75 9pt \"NanumGothic\";\n" \
"color: rgb(255,255,255);\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout.addWidget(@remove)

    @delete_all = Qt::PushButton.new(@centralwidget)
    @delete_all.objectName = "delete_all"
    @delete_all.styleSheet = "font: 75 9pt \"NanumGothic\";\n" \
"color: rgb(255,255,255);\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout.addWidget(@delete_all)


    @verticalLayout.addLayout(@horizontalLayout)

    @verticalLayout_3 = Qt::VBoxLayout.new()
    @verticalLayout_3.objectName = "verticalLayout_3"
    @horizontalLayout_2 = Qt::HBoxLayout.new()
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @sort_by_author = Qt::PushButton.new(@centralwidget)
    @sort_by_author.objectName = "sort_by_author"
    @sort_by_author.maximumSize = Qt::Size.new(16777215, 17)
    @sort_by_author.styleSheet = "font: 75 8pt \"NanumGothic\";"

    @horizontalLayout_2.addWidget(@sort_by_author)

    @sort_by_title = Qt::PushButton.new(@centralwidget)
    @sort_by_title.objectName = "sort_by_title"
    @sort_by_title.maximumSize = Qt::Size.new(16777215, 17)
    @sort_by_title.styleSheet = "font: 75 8pt \"NanumGothic\";"

    @horizontalLayout_2.addWidget(@sort_by_title)


    @verticalLayout_3.addLayout(@horizontalLayout_2)


    @verticalLayout.addLayout(@verticalLayout_3)

    @verticalLayout_2 = Qt::VBoxLayout.new()
    @verticalLayout_2.objectName = "verticalLayout_2"
    @song_list = Qt::ListWidget.new(@centralwidget)
    @song_list.objectName = "song_list"
    @song_list.styleSheet = "font: 63 9pt \"URW Gothic L\";\n" \
"background-image: url(\"%{folder}/resources/%{subfolder}/bg.png\");"

    @verticalLayout_2.addWidget(@song_list)

    @label = Qt::Label.new(@centralwidget)
    @label.objectName = "label"

    @verticalLayout_2.addWidget(@label)

    @search = Qt::LineEdit.new(@centralwidget)
    @search.objectName = "search"
    @search.styleSheet = "background: none"

    @verticalLayout_2.addWidget(@search)


    @verticalLayout.addLayout(@verticalLayout_2)

    listWindow.centralWidget = @centralwidget

    retranslateUi(listWindow)

    Qt::MetaObject.connectSlotsByName(listWindow)
    end # setupUi

    def setup_ui(listWindow)
        setupUi(listWindow)
    end

    def retranslateUi(listWindow)
    listWindow.windowTitle = Qt::Application.translate("ListWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8)
    @enqueue_folder.text = Qt::Application.translate("ListWindow", "enqueue folder", nil, Qt::Application::UnicodeUTF8)
    @enqueue_file.text = Qt::Application.translate("ListWindow", "enqueue file", nil, Qt::Application::UnicodeUTF8)
    @remove.text = Qt::Application.translate("ListWindow", "remove song", nil, Qt::Application::UnicodeUTF8)
    @delete_all.text = Qt::Application.translate("ListWindow", "delete all", nil, Qt::Application::UnicodeUTF8)
    @sort_by_author.text = Qt::Application.translate("ListWindow", "author", nil, Qt::Application::UnicodeUTF8)
    @sort_by_title.text = Qt::Application.translate("ListWindow", "title", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("ListWindow", "Search:", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(listWindow)
        retranslateUi(listWindow)
    end

end

module Ui
    class ListWindow < Ui_ListWindow
    end
end  # module Ui

