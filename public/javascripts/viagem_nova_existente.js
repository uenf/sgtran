function initialize()
{
    viagemNovaOuExistente();
}

function viagemNovaOuExistente()
{
    var viagemNova = document.getElementById("escolha_de_viagem_nova").checked

    if (viagemNova == true)
    {
        document.getElementById("viagem_nova").className = "visivel"
        document.getElementById("viagens_existentes").className = "invisivel"
    }
    else
    {
        document.getElementById("viagens_existentes").className = "visivel"
        document.getElementById("viagem_nova").className = "invisivel"
    }
}

