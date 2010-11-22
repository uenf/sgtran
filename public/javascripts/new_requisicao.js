function initialize()
{
    verificarOutros();
}


function verificarOutros()
{
    var campo = document.getElementById("requisicao_objetivo_de_reserva_id")
    var opcoes = campo.options
    var tamanho = campo.length
    var id_outros
    for(i = 0; i < tamanho; i++)
    {
        if (campo[i].textContent == "Outros")
        {
            id_outros = campo[i].value;
            break;
        }
    }
    if (campo.value == id_outros)
    {
        document.getElementById("requisicao_outros").className = ''
        document.getElementById("requisicao_outros_label").className = 'label_obrigatorio'
    }
    else
    {
        document.getElementById("requisicao_outros").value = ''
        document.getElementById("requisicao_outros").className = 'invisivel'
        document.getElementById("requisicao_outros_label").className = 'invisivel'
    }
}

