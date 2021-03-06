require 'date'

class Datafile < ActiveRecord::Base

  has_many :depositos
  has_many :fechavalors
  has_many :transaccions

  def initialize(params = nil)
    super
      self.fecha_hora_carga = Time.now unless self.fecha_hora_carga
      self.nombre_cliente = "Fecha Valor" unless  self.nombre_cliente 
  end



    def self.save_file_csv(upload)
    name =  upload["file"].original_filename
    directory = "public/tmp"
    # ---  Creamos el Path ----
    path = File.join(directory, name)
    # ---- Escribimos el archivo  -----
    File.open(path, "wb") { |f| f.write(upload['file'].read) }
    #---- Primero vamos a verificar si el encabezado es correcto y no se repite ------
    #---- Iteramos ----
    num_linea = 1
    File.open("#{RAILS_ROOT}/public/tmp/#{name}").each do |linea|
        case num_linea
          when 2
            if linea =~/(\d+)/
                @numero_cliente = $1
            else
              return false
            end
          when 4 #--- Fecha ---
            if linea =~/(\d+)/
             v= $1
              @fecha_hora_archivo = Date.new(v[4,4].to_i, v[2,2].to_i, v[0,2].to_i)
                 else
              return false
            end
          when 5
            if linea =~/(\d+)/
              @sucursal = $1
                 else
              return false
            end
          when 6
            if linea =~/(\d+)/
              @cuenta = $1
                 else
              return false
            end
        when 9
          if linea =~/(\d+)/
              @num_movimientos = $1
          else
              return false
          end

         else
         
          #--- Aqui va a insertar los registros en la tabla depositos ---
        end
        num_linea+= 1

    end
            @data = Datafile.create(:nombre_archivo => name, :numero_cliente => @numero_cliente,
                                :fecha_hora_archivo => @fecha_hora_archivo, :sucursal => @sucursal,
                                :cuenta => @cuenta, :num_movimientos => @num_movimientos)
  end


  def self.save_file_txt(upload)
    name =  upload["file"].original_filename
    directory = "public/tmp"
    # ---  Creamos el Path ----
    path = File.join(directory, name)
    # ---- Escribimos el archivo  -----
    File.open(path, "wb") { |f| f.write(upload['file'].read) }
    @data = Datafile.new(:nombre_archivo => name)
    #---- Primero vamos a verificar si el encabezado es correcto y no se repite ------
    if encabezado_valido?(name) && @data
       if inserta_metadatos(name, @data)
          return @data
          #---- Aqui vamos a insertar los pagos -----
       else
          File.delete("#{RAILS_ROOT}/public/tmp/#{name}") if File.exists?("#{RAILS_ROOT}/public/tmp/#{name}")
          return false
       end
    else
      File.delete("#{RAILS_ROOT}/public/tmp/#{name}") if File.exists?("#{RAILS_ROOT}/public/tmp/#{name}")
      return false
    end
  end



#--- Lee archivo csv para fecha valor ----
def self.save_file_csv_fecha_valor(upload)
  name =  upload["file"].original_filename
    directory = "public/tmp"
    # ---  Creamos el Path ----
    path = File.join(directory, name)
    # ---- Escribimos el archivo  -----
    File.open(path, "wb") { |f| f.write(upload['file'].read) }
    return @data = Datafile.create(:nombre_archivo => name)
end
end #-- Termina clase
