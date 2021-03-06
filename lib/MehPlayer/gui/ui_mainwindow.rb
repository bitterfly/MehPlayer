=begin
** Form generated from reading ui file 'mainwindow.ui'
**
** Created: Thu Feb 5 00:41:32 2015
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_MainWindow
    attr_reader :widget
    attr_reader :horizontalLayout_6
    attr_reader :vertical
    attr_reader :horizontalFrame_2
    attr_reader :horizontalLayout_2
    attr_reader :horizontalLayout_5
    attr_reader :info
    attr_reader :song_info
    attr_reader :rating
    attr_reader :track
    attr_reader :title
    attr_reader :dash2
    attr_reader :artist
    attr_reader :dash1
    attr_reader :horizontalSpacer
    attr_reader :album
    attr_reader :slider
    attr_reader :horizontalFrame
    attr_reader :horizontalLayout
    attr_reader :horizontalFrame_3
    attr_reader :buttons
    attr_reader :save_playlist
    attr_reader :open_playlist
    attr_reader :open_file
    attr_reader :open_folder
    attr_reader :horizontalSpacer_5
    attr_reader :horizontalFrame_8
    attr_reader :horizontalLayout_7
    attr_reader :horizontalSpacer_2
    attr_reader :prev
    attr_reader :play_button
    attr_reader :stop_button
    attr_reader :next
    attr_reader :horizontalSpacer_4
    attr_reader :horizontalSpacer_3
    attr_reader :shuffle
    attr_reader :mute
    attr_reader :repeat
    attr_reader :set_description
    attr_reader :show_list
    attr_reader :rate
    attr_reader :color
    attr_reader :line
    attr_reader :volume

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(687, 179)
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Fixed, Qt::SizePolicy::Fixed)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = mainWindow.sizePolicy.hasHeightForWidth
    mainWindow.sizePolicy = @sizePolicy
    mainWindow.cursor = Qt::Cursor.new(Qt::OpenHandCursor)
    mainWindow.styleSheet = ""
    @widget = Qt::Widget.new(mainWindow)
    @widget.objectName = "widget"
    @widget.styleSheet = ""
    @horizontalLayout_6 = Qt::HBoxLayout.new(@widget)
    @horizontalLayout_6.objectName = "horizontalLayout_6"
    @vertical = Qt::VBoxLayout.new()
    @vertical.objectName = "vertical"
    @horizontalFrame_2 = Qt::Frame.new(@widget)
    @horizontalFrame_2.objectName = "horizontalFrame_2"
    @horizontalFrame_2.styleSheet = "background-repeat: repeat-x;\n" \
"background-image: url(\"%{folder}/resources/%{subfolder}/bg2.png\");"
    @horizontalFrame_2.frameShape = Qt::Frame::Panel
    @horizontalFrame_2.frameShadow = Qt::Frame::Sunken
    @horizontalFrame_2.lineWidth = 3
    @horizontalFrame_2.midLineWidth = 1
    @horizontalLayout_2 = Qt::HBoxLayout.new(@horizontalFrame_2)
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @horizontalLayout_5 = Qt::HBoxLayout.new()
    @horizontalLayout_5.objectName = "horizontalLayout_5"
    @info = Qt::Frame.new(@horizontalFrame_2)
    @info.objectName = "info"
    @info.styleSheet = "background: none"
    @song_info = Qt::HBoxLayout.new(@info)
    @song_info.objectName = "song_info"
    @rating = Qt::Label.new(@info)
    @rating.objectName = "rating"

    @song_info.addWidget(@rating)

    @track = Qt::Label.new(@info)
    @track.objectName = "track"
    @track.styleSheet = "background: none"

    @song_info.addWidget(@track)

    @title = Qt::Label.new(@info)
    @title.objectName = "title"
    @title.styleSheet = "background: none"

    @song_info.addWidget(@title)

    @dash2 = Qt::Label.new(@info)
    @dash2.objectName = "dash2"
    @dash2.maximumSize = Qt::Size.new(20, 30)
    @dash2.styleSheet = "background: none"

    @song_info.addWidget(@dash2)

    @artist = Qt::Label.new(@info)
    @artist.objectName = "artist"
    @artist.styleSheet = "background: none"

    @song_info.addWidget(@artist)

    @dash1 = Qt::Label.new(@info)
    @dash1.objectName = "dash1"
    @dash1.maximumSize = Qt::Size.new(20, 30)
    @dash1.styleSheet = "background: none"

    @song_info.addWidget(@dash1)

    @horizontalSpacer = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @song_info.addItem(@horizontalSpacer)

    @album = Qt::Label.new(@info)
    @album.objectName = "album"
    @album.styleSheet = "background: none"

    @song_info.addWidget(@album)


    @horizontalLayout_5.addWidget(@info)


    @horizontalLayout_2.addLayout(@horizontalLayout_5)


    @vertical.addWidget(@horizontalFrame_2)

    @slider = Qt::Slider.new(@widget)
    @slider.objectName = "slider"
    @slider.styleSheet = "background: none"
    @slider.tracking = true
    @slider.orientation = Qt::Horizontal
    @slider.tickPosition = Qt::Slider::NoTicks

    @vertical.addWidget(@slider)

    @horizontalFrame = Qt::Frame.new(@widget)
    @horizontalFrame.objectName = "horizontalFrame"
    @horizontalFrame.styleSheet = ""
    @horizontalFrame.frameShape = Qt::Frame::Box
    @horizontalFrame.frameShadow = Qt::Frame::Sunken
    @horizontalFrame.lineWidth = 1
    @horizontalLayout = Qt::HBoxLayout.new(@horizontalFrame)
    @horizontalLayout.objectName = "horizontalLayout"
    @horizontalLayout.sizeConstraint = Qt::Layout::SetDefaultConstraint
    @horizontalFrame_3 = Qt::Frame.new(@horizontalFrame)
    @horizontalFrame_3.objectName = "horizontalFrame_3"
    @horizontalFrame_3.frameShape = Qt::Frame::NoFrame
    @horizontalFrame_3.frameShadow = Qt::Frame::Sunken
    @buttons = Qt::HBoxLayout.new(@horizontalFrame_3)
    @buttons.objectName = "buttons"
    @save_playlist = Qt::PushButton.new(@horizontalFrame_3)
    @save_playlist.objectName = "save_playlist"
    @save_playlist.maximumSize = Qt::Size.new(30, 30)
    @save_playlist.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @buttons.addWidget(@save_playlist)

    @open_playlist = Qt::PushButton.new(@horizontalFrame_3)
    @open_playlist.objectName = "open_playlist"
    @open_playlist.maximumSize = Qt::Size.new(30, 30)
    @open_playlist.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @buttons.addWidget(@open_playlist)

    @open_file = Qt::PushButton.new(@horizontalFrame_3)
    @open_file.objectName = "open_file"
    @sizePolicy.heightForWidth = @open_file.sizePolicy.hasHeightForWidth
    @open_file.sizePolicy = @sizePolicy
    @open_file.maximumSize = Qt::Size.new(30, 30)
    @open_file.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @buttons.addWidget(@open_file)

    @open_folder = Qt::PushButton.new(@horizontalFrame_3)
    @open_folder.objectName = "open_folder"
    @sizePolicy.heightForWidth = @open_folder.sizePolicy.hasHeightForWidth
    @open_folder.sizePolicy = @sizePolicy
    @open_folder.maximumSize = Qt::Size.new(30, 30)
    @open_folder.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @buttons.addWidget(@open_folder)


    @horizontalLayout.addWidget(@horizontalFrame_3)

    @horizontalSpacer_5 = Qt::SpacerItem.new(20, 20, Qt::SizePolicy::Maximum, Qt::SizePolicy::Minimum)

    @horizontalLayout.addItem(@horizontalSpacer_5)

    @horizontalFrame_8 = Qt::Frame.new(@horizontalFrame)
    @horizontalFrame_8.objectName = "horizontalFrame_8"
    @horizontalFrame_8.frameShape = Qt::Frame::HLine
    @horizontalFrame_8.frameShadow = Qt::Frame::Raised
    @horizontalLayout_7 = Qt::HBoxLayout.new(@horizontalFrame_8)
    @horizontalLayout_7.objectName = "horizontalLayout_7"
    @horizontalSpacer_2 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_7.addItem(@horizontalSpacer_2)

    @prev = Qt::PushButton.new(@horizontalFrame_8)
    @prev.objectName = "prev"
    @prev.maximumSize = Qt::Size.new(25, 25)
    @prev.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout_7.addWidget(@prev)

    @play_button = Qt::PushButton.new(@horizontalFrame_8)
    @play_button.objectName = "play_button"
    @sizePolicy.heightForWidth = @play_button.sizePolicy.hasHeightForWidth
    @play_button.sizePolicy = @sizePolicy
    @play_button.maximumSize = Qt::Size.new(25, 25)
    @play_button.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"
    icon = Qt::Icon.new
    icon.addPixmap(Qt::Pixmap.new(":/icons/resources/play.png"), Qt::Icon::Normal, Qt::Icon::Off)
    @play_button.icon = icon

    @horizontalLayout_7.addWidget(@play_button)

    @stop_button = Qt::PushButton.new(@horizontalFrame_8)
    @stop_button.objectName = "stop_button"
    @sizePolicy.heightForWidth = @stop_button.sizePolicy.hasHeightForWidth
    @stop_button.sizePolicy = @sizePolicy
    @stop_button.maximumSize = Qt::Size.new(25, 25)
    @stop_button.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout_7.addWidget(@stop_button)

    @next = Qt::PushButton.new(@horizontalFrame_8)
    @next.objectName = "next"
    @next.maximumSize = Qt::Size.new(25, 25)
    @next.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout_7.addWidget(@next)

    @horizontalSpacer_4 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_7.addItem(@horizontalSpacer_4)


    @horizontalLayout.addWidget(@horizontalFrame_8)

    @horizontalSpacer_3 = Qt::SpacerItem.new(20, 20, Qt::SizePolicy::Maximum, Qt::SizePolicy::Minimum)

    @horizontalLayout.addItem(@horizontalSpacer_3)

    @shuffle = Qt::CheckBox.new(@horizontalFrame)
    @shuffle.objectName = "shuffle"
    @shuffle.maximumSize = Qt::Size.new(25, 25)
    @shuffle.styleSheet = " QCheckBox::indicator {\n" \
"     width: 18px;\n" \
"     height: 18px;\n" \
" }\n" \
"\n" \
"  QCheckBox::indicator:checked\n" \
"  {\n" \
"    image: url(\"%{folder}/resources/%{subfolder}/shuffle_off.png\");\n" \
"  }\n" \
"  QCheckBox::indicator:unchecked\n" \
"  {\n" \
"    image: url(\"%{folder}/resources/%{subfolder}/shuffle.png\");\n" \
"  }"

    @horizontalLayout.addWidget(@shuffle)

    @mute = Qt::CheckBox.new(@horizontalFrame)
    @mute.objectName = "mute"
    @mute.styleSheet = " QCheckBox::indicator {\n" \
"     width: 18px;\n" \
"     height: 18px;\n" \
" }\n" \
"\n" \
"  QCheckBox::indicator:checked\n" \
"  {\n" \
"    image: url(\"%{folder}/resources/%{subfolder}/mute2.png\");\n" \
"  }\n" \
"  QCheckBox::indicator:unchecked\n" \
"  {\n" \
"    image: url(\"%{folder}/resources/%{subfolder}/mute1.png\");\n" \
"  }"

    @horizontalLayout.addWidget(@mute)

    @repeat = Qt::CheckBox.new(@horizontalFrame)
    @repeat.objectName = "repeat"
    @repeat.maximumSize = Qt::Size.new(25, 25)
    @repeat.styleSheet = " QCheckBox::indicator {\n" \
"     width: 18px;\n" \
"     height: 18px;\n" \
" }\n" \
"\n" \
"  QCheckBox::indicator:checked\n" \
"  {\n" \
"    image: url(\"%{folder}/resources/%{subfolder}/unrepeat.png\");\n" \
"  }\n" \
"  QCheckBox::indicator:unchecked\n" \
"  {\n" \
"    image: url(\"%{folder}/resources/%{subfolder}/repeat.png\");\n" \
"  }"

    @horizontalLayout.addWidget(@repeat)

    @set_description = Qt::PushButton.new(@horizontalFrame)
    @set_description.objectName = "set_description"
    @set_description.maximumSize = Qt::Size.new(25, 25)
    @set_description.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout.addWidget(@set_description)

    @show_list = Qt::PushButton.new(@horizontalFrame)
    @show_list.objectName = "show_list"
    @show_list.maximumSize = Qt::Size.new(30, 30)
    @show_list.styleSheet = "font: 9pt \"NanumMyeongjo\";\n" \
"background: rgb(165, 165, 167)"

    @horizontalLayout.addWidget(@show_list)

    @rate = Qt::SpinBox.new(@horizontalFrame)
    @rate.objectName = "rate"
    @rate.styleSheet = "background: none;\n" \
"subcontrol-origin: border;\n" \
" subcontrol-position: bottom right; "
    @rate.minimum = 1
    @rate.maximum = 10

    @horizontalLayout.addWidget(@rate)

    @color = Qt::PushButton.new(@horizontalFrame)
    @color.objectName = "color"
    @color.maximumSize = Qt::Size.new(25, 25)
    @color.styleSheet = "background: none"

    @horizontalLayout.addWidget(@color)


    @vertical.addWidget(@horizontalFrame)


    @horizontalLayout_6.addLayout(@vertical)

    @line = Qt::Frame.new(@widget)
    @line.objectName = "line"
    @line.setFrameShape(Qt::Frame::VLine)
    @line.setFrameShadow(Qt::Frame::Sunken)

    @horizontalLayout_6.addWidget(@line)

    @volume = Qt::Slider.new(@widget)
    @volume.objectName = "volume"
    @sizePolicy1 = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Fixed)
    @sizePolicy1.setHorizontalStretch(0)
    @sizePolicy1.setVerticalStretch(0)
    @sizePolicy1.heightForWidth = @volume.sizePolicy.hasHeightForWidth
    @volume.sizePolicy = @sizePolicy1
    @volume.minimumSize = Qt::Size.new(0, 130)
    @volume.maximumSize = Qt::Size.new(23, 220)
    @volume.styleSheet = ""
    @volume.minimum = 0
    @volume.maximum = 100
    @volume.singleStep = 1
    @volume.pageStep = 1
    @volume.sliderPosition = 70
    @volume.tracking = true
    @volume.orientation = Qt::Vertical
    @volume.invertedAppearance = false
    @volume.invertedControls = false
    @volume.tickPosition = Qt::Slider::TicksBelow
    @volume.tickInterval = 6

    @horizontalLayout_6.addWidget(@volume)

    mainWindow.centralWidget = @widget

    retranslateUi(mainWindow)

    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8)
    @rating.text = ''
    @track.text = ''
    @title.text = ''
    @dash2.text = Qt::Application.translate("MainWindow", "-", nil, Qt::Application::UnicodeUTF8)
    @artist.text = ''
    @dash1.text = Qt::Application.translate("MainWindow", "-", nil, Qt::Application::UnicodeUTF8)
    @album.text = ''
    @save_playlist.text = ''
    @open_playlist.text = ''
    @open_file.text = ''
    @open_folder.text = ''
    @prev.text = ''
    @play_button.text = ''
    @stop_button.text = ''
    @next.text = ''
    @shuffle.text = ''
    @mute.text = ''
    @repeat.text = Qt::Application.translate("MainWindow", "repeat", nil, Qt::Application::UnicodeUTF8)
    @set_description.text = ''
    @show_list.text = ''
    @color.text = ''
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

