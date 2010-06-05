class CreateClientes < ActiveRecord::Migration
  def self.up
    create_table :clientes do |t|
      t.column :paterno, :string
      t.column :materno, :string
      t.column :nombre , :string
      t.column :fecha_nac, :date
      t.column :rfc , :string, :limit => 13
      t.column :curp , :string , :limit => 18
      t.column :clave_ife, :string
      t.column :sexo, :string, :limit => 1
      t.column :nacionalidad, :string
      t.column :tipo_propiedad, :string
      t.column :tipo_persona, :string
      t.column :direccion, :string
      t.column :codigo_postal , :string
      t.column :telefono, :string, :limit => 10
      t.column :email, :string
      #--- Relaciones con otras tablas ---
      t.column :civil_id, :integer
      t.column :escolaridad_id, :integer
      t.column :vivienda_id, :integer
      t.column :colonia_id, :integer
      t.column :grupo_id, :integer, :default => 1
end
  end

  def self.down
    drop_table :clientes
  end
end
