﻿using Carros.Dominio.Entidades;
using System.Collections.Generic;

namespace Carros.Dominio.Interfaces.Servico
{
    public interface IServiceMarca : IServiceBase<Marca>
    {
        void Salvar(Marca profissao);
        List<Marca> ListarPorNome(string nome, int id = 0);
    }
}
