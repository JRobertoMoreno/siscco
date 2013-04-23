class CreateViviendas < ActiveRecord::Migration
  def self.up
    create_table :viviendas do |t|
      t.column :tipo_vivienda, :string
    end

    Vivienda.create(:tipo_vivienda => "DE ADOBE")
    Vivienda.create(:tipo_vivienda => "DE LADRILLO")
    Vivienda.create(:tipo_vivienda => "DE MADERA")
    Vivienda.create(:tipo_vivienda => "DE MATERIAL MIXTO")
    Vivienda.create(:tipo_vivienda => "DE PAJAS, RAMAS O CAÑAS")
  end

  def self.down
    drop_table :viviendas
  end
end
