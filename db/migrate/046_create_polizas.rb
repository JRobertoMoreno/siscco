class CreatePolizas < ActiveRecord::Migration
  def self.up
    create_table :polizas do |t|
      t.column :fecha, :date
      t.column :tipo_poliza, :string, :limit => 1
      t.column :num_poliza, :string, :limit => 6
      t.column :cuenta_id, :integer
      t.column :naturaleza, :string, :limit => 25
      t.column :importe, :string, :limit => 18
      t.column :descripcion, :string, :limit => 60
      t.column :identificador, :string, :limit => 3
  

      #      t.column :iEjer, :integer
#      t.column :iMes, :integer
#      t.column :sTpPol, :string, :limit => 3
#      t.column :sPolNum, :string, :limit => 6
#      t.column :sPolMov, :string, :limit => 6
#      t.column :iDia, :integer
#      t.column :iNatura, :integer
#      t.column :rImpMov, :real
#      t.column :sCvIVA, :string, :limit => 1
#      t.column :iAplica, :integer
#      t.column :sCnc, :string, :limit => 3
#      t.column :sRefere, :string,:limit => 8
#      t.column :sClvCnc, :string, :limit => 3
#      t.column :sNatMov, :string, :limit => 1
#      t.column :rImpMovRS, :real
#      t.column :sCtaNom, :string, :limit => 30
#      t.column :cuenta_id, :integer

    end
  end

  def self.down
    drop_table :polizas
  end
end
