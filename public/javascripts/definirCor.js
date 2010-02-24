    function definirCor()
    {
      var url = document.location.pathname

      if (url.search(/requisic(ao|oes)/) != -1)
      {
        document.getElementById("opcao_viagem").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_base_de_dados").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_viagem").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_base_de_dados").style.borderBottom = '#DCDCDC'
      }
      else if (url.search(/viage(ns|m)/) != -1)
      {
        document.getElementById("opcao_requisicao").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_base_de_dados").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_requisicao").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_base_de_dados").style.borderBottom = '#DCDCDC'
      }
      else if (url.search(/base_de_dados/) != -1)
      {
        document.getElementById("opcao_requisicao").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_viagem").style.backgroundColor = '#DCDCDC'
        document.getElementById("opcao_requisicao").style.borderBottom = '#DCDCDC'
        document.getElementById("opcao_viagem").style.borderBottom = '#DCDCDC'
      }
    }

