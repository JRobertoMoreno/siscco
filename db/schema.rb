# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 32) do

  create_table "bancos", :force => true do |t|
    t.column "nombre",     :string
    t.column "num_cuenta", :string
    t.column "titular",    :string
    t.column "direccion",  :string
    t.column "telefono",   :string
    t.column "colonia_id", :string
  end

  create_table "civils", :force => true do |t|
    t.column "civil", :string
  end

  create_table "clientes", :force => true do |t|
    t.column "paterno",        :string
    t.column "materno",        :string
    t.column "nombre",         :string
    t.column "fecha_nac",      :date
    t.column "rfc",            :string,  :limit => 13
    t.column "curp",           :string,  :limit => 18
    t.column "clave_ife",      :string
    t.column "sexo",           :string,  :limit => 1
    t.column "nacionalidad",   :string
    t.column "tipo_propiedad", :string
    t.column "tipo_persona",   :string
    t.column "direccion",      :string
    t.column "codigo_postal",  :string
    t.column "telefono",       :string,  :limit => 10
    t.column "email",          :string
    t.column "civil_id",       :integer
    t.column "escolaridad_id", :integer
    t.column "vivienda_id",    :integer
    t.column "colonia_id",     :integer
    t.column "grupo_id",       :integer,               :default => 1
  end

  create_table "colonias", :force => true do |t|
    t.column "colonia",     :string
    t.column "clave_inegi", :string
    t.column "ejido_id",    :integer
  end

  create_table "creditos", :force => true do |t|
    t.column "fecha_inicio",      :date
    t.column "fecha_fin",         :date
    t.column "num_referencia",    :string
    t.column "linea_id",          :integer
    t.column "banco_id",          :integer
    t.column "cliente_id",        :integer
    t.column "promotor_id",       :integer
    t.column "destino_id",        :integer
    t.column "grupo_id",          :integer
    t.column "periodo_id",        :integer
    t.column "monto",             :float
    t.column "tasa_interes",      :float
    t.column "num_pagos",         :integer
    t.column "interes_moratorio", :integer
  end

  create_table "destinos", :force => true do |t|
    t.column "destino", :string
  end

  create_table "ejidos", :force => true do |t|
    t.column "ejido",        :string
    t.column "clave_inegi",  :string
    t.column "municipio_id", :integer
  end

  create_table "escolaridads", :force => true do |t|
    t.column "escolaridad", :string
  end

  create_table "estados", :force => true do |t|
    t.column "estado", :string
  end

  create_table "festivos", :force => true do |t|
    t.column "fecha",       :date
    t.column "descripcion", :string
  end

  create_table "fondeos", :force => true do |t|
    t.column "fuente", :string
  end

  create_table "garantias", :force => true do |t|
    t.column "garantia", :string
  end

  create_table "garantias_referencias", :id => false, :force => true do |t|
    t.column "referencia_id", :integer
    t.column "garantia_id",   :integer
  end

  create_table "giros", :force => true do |t|
    t.column "subsector", :string
    t.column "codigo",    :string
    t.column "giro",      :string
  end

  create_table "grupos", :force => true do |t|
    t.column "nombre", :string
  end

  create_table "lineas", :force => true do |t|
    t.column "fondeo_id",          :integer
    t.column "cuenta_cheques",     :string
    t.column "fecha_autorizacion", :date
    t.column "linea_autorizada",   :string
    t.column "estatus",            :string,  :limit => 5
    t.column "gcnf",               :string
  end

  create_table "movimientos", :force => true do |t|
    t.column "tipo",     :string
    t.column "capital",  :float
    t.column "fecha",    :date
    t.column "interes",  :float
    t.column "concepto", :string
    t.column "pago_id",  :integer
  end

  create_table "municipios", :force => true do |t|
    t.column "municipio",   :string
    t.column "clave_inegi", :string
    t.column "estado_id",   :integer
  end

  create_table "negocios", :force => true do |t|
    t.column "nombre",        :string
    t.column "puesto",        :string
    t.column "direccion",     :string
    t.column "telefono",      :string,  :limit => 10
    t.column "num_empleados", :integer
    t.column "cliente_id",    :integer
    t.column "giro_id",       :integer
  end

  create_table "pagos", :force => true do |t|
    t.column "num_pago",       :integer
    t.column "fecha_limite",   :date
    t.column "capital_minimo", :string
    t.column "interes_minimo", :string
    t.column "fecha",          :date
    t.column "capital",        :string
    t.column "interes",        :string
    t.column "moratorio",      :string
    t.column "pagado",         :integer
    t.column "credito_id",     :integer
  end

  create_table "pagoslineas", :force => true do |t|
    t.column "linea_id",      :integer
    t.column "fecha",         :date
    t.column "monto",         :string
    t.column "observaciones", :string
  end

  create_table "periodos", :force => true do |t|
    t.column "nombre", :string
    t.column "dias",   :integer
  end

  create_table "productos", :force => true do |t|
    t.column "producto",            :string
    t.column "tipo",                :string
    t.column "intereses",           :float
    t.column "iva_intereses",       :float
    t.column "intereses_moratorio", :float
    t.column "multa",               :float
    t.column "iva_multa",           :float
    t.column "garantia",            :float
    t.column "periodo_id",          :integer
    t.column "grupo_id",            :integer
  end

  create_table "promotors", :force => true do |t|
    t.column "paterno",       :string
    t.column "materno",       :string
    t.column "nombre",        :string
    t.column "direccion",     :string
    t.column "telefono",      :string, :limit => 10
    t.column "celular",       :string, :limit => 10
    t.column "email",         :string
    t.column "observaciones", :string
  end

  create_table "referencias", :force => true do |t|
    t.column "paterno",    :string
    t.column "materno",    :string
    t.column "nombre",     :string
    t.column "parentesco", :string
    t.column "direccion",  :string
    t.column "telefono",   :string,  :limit => 10
    t.column "tipo",       :string
    t.column "credito_id", :integer
  end

  create_table "rols", :force => true do |t|
    t.column "nombre", :string
  end

  create_table "sectors", :force => true do |t|
    t.column "sector", :string
  end

  create_table "status", :force => true do |t|
    t.column "statu", :string
  end

  create_table "subsectors", :force => true do |t|
    t.column "subsector", :string
    t.column "sector_id", :integer
  end

  create_table "sucursals", :force => true do |t|
    t.column "nombre",        :string
    t.column "rfc",           :string,  :limit => 13
    t.column "gerente",       :string
    t.column "telefono",      :string
    t.column "direccion",     :string
    t.column "codigo_postal", :string
    t.column "colonia_id",    :integer
  end

  create_table "systables", :force => true do |t|
    t.column "controller",  :string
    t.column "descripcion", :string
    t.column "rol_id",      :integer
  end

  create_table "users", :force => true do |t|
    t.column "login",    :string
    t.column "password", :string
    t.column "nombre",   :string
    t.column "rol_id",   :integer, :default => 1
  end

  create_table "viviendas", :force => true do |t|
    t.column "tipo_vivienda", :string
  end

end
