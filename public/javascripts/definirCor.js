    function definirCor()
    {
      var url = document.location.pathname

      if (url.search(/requisicoes/) != -1)
      {
        document.getElementById("opcao_viagem").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_base_de_dados").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_viagem").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_base_de_dados").style.borderBottom = '#DCDCDC'
      }
      else if (url.search(/viagens/) != -1)
      {
        document.getElementById("opcao_requisicao").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_base_de_dados").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_requisicao").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_base_de_dados").style.borderBottom = '#DCDCDC'
      }
      else if (url.search(/solicitantes/) != -1)
      {
        document.getElementById("opcao_requisicao").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_requisicao").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.backgroundColor = '#DCDCDC'

        document.getElementById("opcao_motorista").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_motorista").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_veiculo").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_veiculo").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_usuario").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_usuario").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_combustivel").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_combustivel").style.borderBottom = '#DCDCDC'
      }
      else if (url.search(/motoristas/) != -1)
      {
        document.getElementById("opcao_requisicao").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_requisicao").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.backgroundColor = '#DCDCDC'

        document.getElementById("opcao_solicitante").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_solicitante").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_veiculo").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_veiculo").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_usuario").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_usuario").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_combustivel").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_combustivel").style.borderBottom = '#DCDCDC'
      }
      else if (url.search(/veiculo/) != -1)
      {
        document.getElementById("opcao_requisicao").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_requisicao").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.backgroundColor = '#DCDCDC'

        document.getElementById("opcao_solicitante").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_solicitante").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_motorista").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_motorista").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_usuario").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_usuario").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_combustivel").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_combustivel").style.borderBottom = '#DCDCDC'
      }
      else if (url.search(/usuario/) != -1)
      {
        document.getElementById("opcao_requisicao").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_requisicao").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.backgroundColor = '#DCDCDC'

        document.getElementById("opcao_solicitante").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_solicitante").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_motorista").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_motorista").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_veiculo").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_veiculo").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_combustivel").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_combustivel").style.borderBottom = '#DCDCDC'
      }
      else if (url.search(/combustiveis/) != -1)
      {
        document.getElementById("opcao_requisicao").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_requisicao").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.backgroundColor = '#DCDCDC'

        document.getElementById("opcao_solicitante").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_solicitante").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_motorista").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_motorista").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_veiculo").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_veiculo").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_usuario").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_usuario").style.borderBottom = '#DCDCDC'
      }
    }

