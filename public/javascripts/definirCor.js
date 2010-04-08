function definir_aba(aba)
{
    abas = ["opcao_requisicao", "opcao_viagem", "opcao_base_de_dados"]

    for (i = 0; i < abas.length; i++)
    {
        if (abas[i] != aba)
        {
            document.getElementById(abas[i]).style.backgroundColor = '#DCDCDC'
            document.getElementById(abas[i]).style.borderBottom = '#DCDCDC'
        }
    }
}

function definirCor()
{
    var url = document.location.pathname

    if (url.search(/requisic(ao|oes)/) != -1)
    {
        definir_aba("opcao_requisicao")
    }
    else if (url.search(/viage(ns|m)/) != -1)
    {
        definir_aba("opcao_viagem")
    }
    else if (
    (url.search(/base_de_dados/) != -1) ||
    (url.search(/categoria_de_veiculos/) != -1) ||
    (url.search(/combustiveis/) != -1) ||
    (url.search(/solicitantes/) != -1) ||
    (url.search(/motoristas/) != -1) ||
    (url.search(/\/veiculos/) != -1) ||
    (url.search(/usuario/) != -1) ||
    (url.search(/motivo/) != -1) ||
    (url.search(/objetivos_de_reserva/) != -1) ||
    (url.search(/centro/) != -1)
    )
    {
        definir_aba("opcao_base_de_dados")
    }
}

