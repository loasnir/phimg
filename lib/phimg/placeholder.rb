require 'mini_magick'

class Placeholder
  attr_reader :width, :height, :background_color, :text_color, :text

  def initialize(width:, height:, background_color: '#CCCCCC', text_color: '#969696', text: "#{width} x #{height}")
    @width = width
    @height = height
    @background_color = background_color
    @text_color = text_color
    @text = text
  end

  def to_png
    tmp = MiniMagick::Tool::Convert.new do |convert|
      convert.size("#{@width}x#{@height}")
      convert << "xc:#{@background_color}"

      convert.gravity('center')
      convert.fill(@text_color)
      convert.pointsize(24)
      convert.draw("text 0,0 '#{@text}'")

      convert << "png:-"
    end

    MiniMagick::Image.read(tmp)
  end
end

# # 使用例
# placeholder = Placeholder.new(width: 300, height: 200, text: '012345678901234567890123456789')
# image = placeholder.to_png
# image.write('placeholder.png')
