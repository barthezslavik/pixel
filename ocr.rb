class Ocr
  def initialize
    e = Tesseract::Engine.new {|e|
      e.language  = :eng
      e.blacklist = '|'
    }
    abort e.text_for('static/ocr.png').strip.inspect
  end
end
