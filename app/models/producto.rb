class Producto < ActiveRecord::Base
#  belongs_to :grupo
  belongs_to :periodo
  has_many :creditos

  before_save

  def initialize(params = nil)
    super
      self.moratorio_ssi = self.intereses.to_f * 2.0 unless self.moratorio_ssi
      self.moratorio_flat = self.intereses.to_f * 2.0 unless self.moratorio_flat
    end

  def before_save
    self.intereses = self.tasa_anualizada.to_i / 12 if self.tasa_anualizada
  end
end
