function initialize()
{
    verificarOutros();
    setarDataVoltaInvisivel();
    idaeVolta();
}


function verificarOutros()
{
    var campo = document.getElementById("requisicao_objetivo_da_reserva").value
    if (campo == "Outros")
    {
        document.getElementById("requisicao_outros").className = ''
        document.getElementById("requisicao_outros_label").className = 'campo_obrigatorio'
    }
    else
    {
        document.getElementById("requisicao_outros").value = ''
        document.getElementById("requisicao_outros").className = 'invisivel'
        document.getElementById("requisicao_outros_label").className = 'invisivel'
    }
}


function setarDataVoltaInvisivel()
{
    document.getElementById("data_volta").className = "invisivel"
}

function idaeVolta()
{
    var dataIda = document.getElementById("data_de_reserva_ida").checked

    if (dataIda == true)
    {
        document.getElementById("data_volta").className = "invisivel"
        document.getElementById("roteiro_de_volta").className = "invisivel"
    }
    else
    {
        document.getElementById("data_volta").className = "visivel"
        document.getElementById("roteiro_de_volta").className = "visivel"
    }
}

