using Entities.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Contracts
{
    public interface IRoleRepository : IRepositoryBase<Role>
    {
        // HttpGet
        IEnumerable<Role> GetAllRoles();
        Role GetRoleById(int id);

        // HttpPost
        void CreateRole(Role role);

        // HttpPut
        void UpdateRole(Role role);

        // HttpDelete
        void DeleteRole(Role role);
    }
}
