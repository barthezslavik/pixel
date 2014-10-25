class Ocr
  def initialize
    e = Tesseract::Engine.new {|e|
      e.language  = :eng
      e.blacklist = '|'
    }
    #abort e.words_for('static/ocr.png').first.methods.inspect#.font_attributes.inspect
    #abort e.words_for('static/ocr.png').inspect#.font_attributes.inspect
  end
end
