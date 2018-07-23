class NumbersToWordsService
  attr_accessor :number
  UNITS = %w(cero uno dos tres cuatro cinco seis siete ocho nueve)
  TEN = %w(diez once doce trece catorce quince dieciseis diecisiete dieciocho diecinueve)
  TENS = %w(diez veinte treinta cuarenta cincuenta sesenta setenta ochenta noventa)
  HUNDREDS = %w(ciento doscientos trescientos cuatroscientos quinientos seiscientos setecientos ochocientos novecientos)

  def initialize(number)
    @number = number
  end
  def perform
    case number
    when 0..9 then units(number)
    when 10..19 then ten(number)
    when 20..99 then tens(number)
    when 100..999 then hundreds(number)
    when 1000..999_999 then thousands(number)
    when 1_000_000..999_999_999 then millions(number)
    else
      billions(number)
    end
  end

  def self.perform(number)
    new(number).perform
  end

  private
    
    def units(unit)
      UNITS[unit]
    end

    def ten(ten)
      tenn, unit = ten.divmod(10)
      TEN[unit]
    end

    def tens(tens)
      tenn, unit = tens.divmod(10)
      case tens
      when 1 then units(unit)
      when 10..19 then ten(tens)
      when 21..29 then "veinti#{UNITS[unit]}"
      else TENS[tenn - 1] + (unit.positive? ? " y #{UNITS[unit]}" : '')
      end
    end

    def hundreds(hundreds)
      return 'cien' if hundreds == 100
      hundred, tenn = hundreds.divmod(100)
      if tenn.to_s.length == 2
        HUNDREDS[hundred - 1] + (tenn.positive? ? " #{tens(tenn)}" : '')
      else
        HUNDREDS[hundred - 1] + (tenn.positive? ? " #{units(tenn)}" : '')
      end
    end

    def thousands(thousands)
      thousand, hundred = thousands.divmod(1000)
      word = case thousand
      when 2..9 then UNITS[thousand]
      when 10..99 then tens(thousand)
      when 100..999 then hundreds(thousand)
      else ''
      end + ' mil '
      case hundred.to_s.length
      when 1
        word += units(hundred) if hundred.positive?
      when 2
        word += tens(hundred) if hundred.positive?
      else
        word += hundreds(hundred) if hundred.positive?
      end
        word
    end

    def millions(millions)
      million, thousand = millions.divmod(1_000_000)
      word = case million
      when 1 then ' un millon '
      when 2..9 then units(million)
      when 10..99 then tens(million)
      when 100..999 then hundreds(million)
      else ''
      end
      word += ' millones ' unless million == 1
      word + case thousand
      when 1..99 then tens(thousand)
      when 100..999 then hundreds(thousand)
      when 1000..999_999 then thousands(thousand)
      else ''
      end
    end

    def billions(billions)
      billion, million = billions.divmod(1_000_000)
      "#{thousands(billion)} #{millions(million)}"
    end
end
