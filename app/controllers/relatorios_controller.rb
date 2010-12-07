class RelatoriosController < ApplicationController
  access_control do
    allow :admin
  end

  layout "sistema"

  def index
  end

  def km_percorridos
    @relatorio = Relatorio.new
  end

  def show_km_percorridos
    @relatorio = Relatorio.new(params[:relatorio])
    if @relatorio.valid?
      @kms = Bdt.distancia_percorrida_entre(@relatorio.data_inicial,
                                            @relatorio.data_final)

      @motoristas = Motorista.find(:all)

      report = ODFReport::Report.new("#{RAILS_ROOT}/public/reports/quilometragem.odt") do |r|

        r.add_field 'KM_TOTAL', @kms.to_s
        r.add_field 'KM_MEDIA', (@kms/@motoristas.count).to_s
        # Adicinar método no odf-report para conseguir fazer isso.
        # As images no cabeçalho ficam no styles.xml e não no content.xml
        # r.add_image 'CABECALHO', "#{RAILS_ROOT}/public/images/cabecalho_relatorio.eps"

        r.add_table("TABELA_KM_MOTORISTA", @motoristas, :header=>true) do |t|
          t.add_column 'NOME', :nome
          t.add_column 'MATRICULA', :matricula
        end

      end

      report_file_name = report.generate

      send_file(report_file_name)

    else
      render :action => :km_percorridos
    end
  end

end

