using Contracts;
using Entities;
using Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository
{
    class RoleRepository : RepositoryBase<Role>, IRoleRepository
    {
        public RoleRepository(RepositoryContext repositoryContext) 
            : base(repositoryContext)
        {
        }

        public IEnumerable<Role> GetAllRoles()
        {
            return FindAll().ToList();
        }

        public Role GetRoleById(int id)
        {
            return FindByCondition(r => r.Id.Equals(id)).FirstOrDefault();
        }

        public void CreateRole(Role role)
        {
            Create(role);
        }

        public void UpdateRole(Role role)
        {
            Update(role);
        }

        public void DeleteRole(Role role)
        {
            Delete(role);
        }

    }
}
