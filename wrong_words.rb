# frozen_string_literal: true

require 'json'
require 'uri'
require 'net/http'

class WrongWords
  LINK = 'https://speller.yandex.net/services/spellservice.json/checkText?text='.freeze

  def check_text(text)
    parsing_text(text)
  end

  private

  def parsing_text(word)
    e_word = URI.encode_www_form_component(word)
    uri = URI(LINK + e_word)
    res = Net::HTTP.get_response(uri)
    print_info(JSON.parse(res.body)) if res.is_a?(Net::HTTPSuccess)
  end



  def print_info(array)
    if array.empty?
      puts('Все четко')
    else
      bad_words = ''
      array.each do |x|
        bad_words += "#{x['word']} "
      end
      puts("В вашем педложение не правильно были написаны следующие слова: #{bad_words}")
    end
  end

end


obj = WrongWords.new
obj.check_text('I vant to')




