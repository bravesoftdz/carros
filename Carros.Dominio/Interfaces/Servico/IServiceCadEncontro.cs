﻿using Carros.Dominio.Entidades;
using System.Collections.Generic;

namespace Carros.Dominio.Interfaces.Servico
{
    public interface IServiceCadEncontro : IServiceBase<CadEncontro>
    {
        void Salvar(CadEncontro profissao);
        List<CadEncontro> ListarPorNome(string nome, int id = 0);
        CadEncontro ObterNumeroEncontroAtual();
    }
}
