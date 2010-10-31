class CreateDestinos < ActiveRecord::Migration
  def self.up
    create_table :destinos do |t|
      t.column :destino, :string
      t.column :user_id, :integer
      t.column :fecha_hora, :datetime
    end

    Destino.create(:destino=>"CAPITAL DE NEGOCIO")
    Destino.create(:destino => "PAGO DE DEUDA")

  end

  def self.down
    drop_table :destinos
  end
end
