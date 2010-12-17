class RelatoriosController < ApplicationController

  require 'google_chart'

  access_control do
    allow :admin
  end

  layout "sistema"

  def milhar numero
    numero.to_s.contabil[0..-4]
  end

  def index
  end

  def quilometragem
    @relatorio = Relatorio.new
  end

  def generate_quilometragem
    @relatorio = Relatorio.new(params[:relatorio])

    if @relatorio.valid?

      @ano = @relatorio.ano
      @motoristas = Motorista.find(:all, :order => "nome ASC")
      @centros = Centro.find(:all, :order => "nome ASC")
      @km_total = Bdt.distancia_percorrida_entre("01/01/#{@ano}", "31/12/#{@ano}")

      report = ODFReport::Report.new("#{RAILS_ROOT}/public/reports/quilometragem.odt") do |r|

        r.add_field 'ANO', @ano
        r.add_field 'KM_MEDIA_MOTORISTA', milhar(@km_total/@motoristas.count)
        # XXX: Adiconar essa imagem nas configurações para poder substituir aqui.
        #      Lembrar de colocar o nome da imagem do odt e ripar a imagem de lá
        # r.add_image 'CABECALHO', "#{RAILS_ROOT}/public/images/cabecalho_relatorio.eps"

        nome_meses=['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago',
                    'Set', 'Out', 'Nov', 'Dez',]
        cores = ["c8802c", "ba4cd2", "688593", "f0bf02", "735805", "1ca349",
                 "572fa1", "5582dc", "af13ba", "61b8d2", "4b4957", "7c4969"]

        km_geral = []
        for mes in 1..12 do
          data = "01/#{mes}/#{@ano}".to_date
          km_geral << Bdt.distancia_percorrida_entre(data, data.end_of_month)
        end

        GoogleChart::BarChart.new('450x400', 'Quilômetros rodados por mês', :horizontal, false) do |bc|
          positions = []; for i in 0..11 do positions << i*8.35 + 4.5 end
          bc.axis :y, :labels => nome_meses.reverse, :positions => positions
          for i in 0..11 do
            bc.data "#{nome_meses[i]} - #{milhar(km_geral[i])}", [km_geral[i]], cores[i]
          end
          bc.width_spacing_options :bar_width => 20, :bar_spacing => 8
          system "wget -O '/tmp/10000000000001C20000019015AFAFCA.png' '#{bc.to_url(:chts => '676767,16')}'"
          r.add_image 'KM_BARRAS', '/tmp/10000000000001C20000019015AFAFCA.png'
        end

        GoogleChart::PieChart.new('400x300', 'Porcentagem de quilômetros rodados no ano', false) do |pc|
          for i in 0..11 do
            pc.data nome_meses[i], km_geral[i], cores[i]
          end
          system "wget -O '/tmp/10000000000001900000012CEF03521D.png' '#{pc.to_url(:chts => '676767,16')}'"
          r.add_image 'KM_PIZZA', '/tmp/10000000000001900000012CEF03521D.png'
        end

        # XXX: Está sendo feito 12x iterações do que o necessário. Isso devido
        # à implementação do odf-report que não tem um método
        # add_row para casos como esse.
        r.add_table("TABELA_KM_GERAL", (1..13).to_a, :header=>true) do |t|
          t.add_column('1') { |mes| milhar(km_geral[0]) }
          t.add_column('2') { |mes| milhar(km_geral[1]) }
          t.add_column('3') { |mes| milhar(km_geral[2]) }
          t.add_column('4') { |mes| milhar(km_geral[3]) }
          t.add_column('5') { |mes| milhar(km_geral[4]) }
          t.add_column('6') { |mes| milhar(km_geral[5]) }
          t.add_column('7') { |mes| milhar(km_geral[6]) }
          t.add_column('8') { |mes| milhar(km_geral[7]) }
          t.add_column('9') { |mes| milhar(km_geral[8]) }
          t.add_column('10') { |mes| milhar(km_geral[9]) }
          t.add_column('11') { |mes| milhar(km_geral[10]) }
          t.add_column('12') { |mes| milhar(km_geral[11]) }
          t.add_column('TOTAL') { |mes| milhar(@km_total) }
        end

        r.add_table("TABELA_KM_CENTRO", @centros, :header=>true) do |t|
          t.add_column :nome

          t.add_column('1') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/01/#{@ano}", "31/01/#{@ano}"))}
          t.add_column('2') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/02/#{@ano}", "1/02/#{@ano}".to_date.end_of_month))}
          t.add_column('3') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/03/#{@ano}", "31/03/#{@ano}"))}
          t.add_column('4') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/04/#{@ano}", "30/04/#{@ano}"))}
          t.add_column('5') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/05/#{@ano}", "31/05/#{@ano}"))}
          t.add_column('6') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/06/#{@ano}", "30/06/#{@ano}"))}
          t.add_column('7') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/07/#{@ano}", "31/07/#{@ano}"))}
          t.add_column('8') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/08/#{@ano}", "31/08/#{@ano}"))}
          t.add_column('9') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/09/#{@ano}", "30/09/#{@ano}"))}
          t.add_column('10') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/10/#{@ano}", "31/10/#{@ano}"))}
          t.add_column('11') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/11/#{@ano}", "30/11/#{@ano}"))}
          t.add_column('12') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/12/#{@ano}", "31/12/#{@ano}"))}
          t.add_column('TOTAL') { |centro| milhar(centro.distancia_percorrida_entre(
                                    "01/01/#{@ano}", "31/12/#{@ano}"))}
        end

        GoogleChart::PieChart.new('450x300', 'Porcentagem de quilômetros rodados por centro', false) do |pc|
          @centros.each do |centro|
            pc.data centro.nome,
                    centro.distancia_percorrida_entre("01/01/#{@ano}",
                                                      "31/12/#{@ano}"),
                    "%06x" % (rand * 0xffffff) # Cor aleatória
          end
          system "wget -O '/tmp/10000000000001C20000012CF01E15F4.png' '#{pc.to_url(:chts => '676767,16')}'"
          r.add_image 'CENTROS_PIZZA', '/tmp/10000000000001C20000012CF01E15F4.png'
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

  def atendimento
    @relatorio = Relatorio.new
  end

  def porcentagem parte, total
    "%.1f%" % (parte*100/total.to_f)
  end

  def generate_atendimento
    @relatorio = Relatorio.new(params[:relatorio])

    if @relatorio.valid?

      @ano = @relatorio.ano
      @centros = Centro.find(:all, :order => "nome ASC")
      @total = Bdt.distancia_percorrida_entre("01/01/#{@ano}", "31/12/#{@ano}")

      report = ODFReport::Report.new("#{RAILS_ROOT}/public/reports/atendimento.odt") do |r|

        r.add_field 'ANO', @ano
        # XXX: Adiconar essa imagem nas configurações para poder substituir aqui.
        #      Lembrar de colocar o nome da imagem do odt e ripar a imagem de lá
        # r.add_image 'CABECALHO', "#{RAILS_ROOT}/public/images/cabecalho_relatorio.eps"

#        tem que adicionar as datas de inicio e fim nessas consultas
        total = Requisicao.find(:all, :conditions => [
                                      "estado != ? AND estado != ?",
                                      Requisicao::ESPERA, Requisicao::ACEITA]).count
        r.add_field 'GERAL_TOTAL', total
        atendidas = Requisicao.find_all_by_estado(Requisicao::FINALIZADA).count
        r.add_field 'GERAL_ATEN', atendidas
        r.add_field 'GERAL_ATEN_PORC', porcentagem(atendidas,total)
        rejeitadas = Requisicao.find_all_by_estado(Requisicao::REJEITADA).count
        r.add_field 'GERAL_REJEI', rejeitadas
        r.add_field 'GERAL_REJEI_PORC', porcentagem(rejeitadas,total)
        canceladas_setor = Requisicao.find_all_by_estado(Requisicao::CANCELADO_PELO_SISTEMA).count
        r.add_field 'GERAL_C_SET', canceladas_setor
        r.add_field 'GERAL_C_SET_PORC', porcentagem(canceladas_setor,total)
        canceladas_solicitante = Requisicao.find_all_by_estado(Requisicao::CANCELADO_PELO_PROFESSOR).count
        r.add_field 'GERAL_C_SOL', canceladas_solicitante
        r.add_field 'GERAL_C_SOL_PORC', porcentagem(canceladas_solicitante,total)

      end

      report_file_name = report.generate
      send_file(report_file_name)

    else
      render :action => :quilometragem
    end
  end

end

