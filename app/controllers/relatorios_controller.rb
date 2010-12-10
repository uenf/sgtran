class RelatoriosController < ApplicationController
  access_control do
    allow :admin
  end

  layout "sistema"

  def index
  end

  def quilometragem
    @relatorio = Relatorio.new
  end

  def milhar numero
    numero.to_s.contabil[0..-4]
  end

  def generate_quilometragem
    @relatorio = Relatorio.new(params[:relatorio])

    if @relatorio.valid?
      @kms = Bdt.distancia_percorrida_entre(@relatorio.data_inicial,
                                            @relatorio.data_final)
      @ano = @relatorio.data_inicial.year
      @motoristas = Motorista.find(:all, :order => "nome ASC")
      @centros = Centro.find(:all, :order => "nome ASC")

      report = ODFReport::Report.new("#{RAILS_ROOT}/public/reports/quilometragem.odt") do |r|

        r.add_field 'ANO', @ano
        r.add_field 'DATA_INICIAL', @relatorio.data_inicial.strftime("%h %Y")
        r.add_field 'DATA_FINAL', @relatorio.data_final.strftime("%h %Y")
        r.add_field 'KM_TOTAL', milhar(@kms)
        r.add_field 'KM_MEDIA', milhar(@kms/@motoristas.count)
        # XXX: Tem que corrigir o odf-report para poder funcionar o código abaixo
        # r.add_image 'CABECALHO', "#{RAILS_ROOT}/public/images/cabecalho_relatorio.eps"

        r.add_table("TABELA_KM_CENTRO", @centros, :header=>true) do |t|
          t.add_column :nome
        end

        r.add_table("TABELA_KM_MOTORISTA", @motoristas, :header=>true) do |t|
          t.add_column 'NOME', :nome_e_sobrenome

          # XXX: Esse código substitui todo o código da tabela, mas por motivos
          # satanisticos não está funcionando. Provavelmente é a forma como o
          # add_column trata internamente o bloco.
          # for mes in 1..2
          #   data = "01/#{mes}/#{@ano}".to_date
          #   t.add_column(mes.to_s) { |motorista| milhar(motorista.distancia_percorrida_entre(data, data.end_of_month)) }
          # end

          t.add_column('1') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/01/#{@ano}", "31/01/#{@ano}"))}
          t.add_column('2') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/02/#{@ano}", "1/02/#{@ano}".to_date.end_of_month))}
          t.add_column('3') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/03/#{@ano}", "31/03/#{@ano}"))}
          t.add_column('4') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/04/#{@ano}", "30/04/#{@ano}"))}
          t.add_column('5') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/05/#{@ano}", "31/05/#{@ano}"))}
          t.add_column('6') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/06/#{@ano}", "30/06/#{@ano}"))}
          t.add_column('7') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/07/#{@ano}", "31/07/#{@ano}"))}
          t.add_column('8') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/08/#{@ano}", "31/08/#{@ano}"))}
          t.add_column('9') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/09/#{@ano}", "30/09/#{@ano}"))}
          t.add_column('10') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/10/#{@ano}", "31/10/#{@ano}"))}
          t.add_column('11') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/11/#{@ano}", "30/11/#{@ano}"))}
          t.add_column('12') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/12/#{@ano}", "31/12/#{@ano}"))}
          t.add_column('TOTAL') { |motorista| milhar(motorista.distancia_percorrida_entre(
                                    "01/01/#{@ano}", "31/12/#{@ano}"))}
        end

      end

      report_file_name = report.generate
      send_file(report_file_name)

    else
      render :action => :quilometragem
    end
  end

end

