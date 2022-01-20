using Contracts;
using Entities;
using Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository
{
    public class UserRepository : RepositoryBase<User>, IUserRepository
    {
        public UserRepository(RepositoryContext repositoryContext) 
            : base(repositoryContext)
        {
        }

        public IEnumerable<User> UsersByRoleId(int roleId)
        {
            return FindByCondition(u => u.RoleId.Equals(roleId)).ToList();
        }

        public IEnumerable<User> GetAllUsers()
        {
            return FindAll().OrderBy(u => u.Name).ToList();
        }

        public User GetUserById(int id)
        {
            return FindByCondition(u => u.Id.Equals(id)).FirstOrDefault();
        }

        public void CreateUser(User user)
        {
            Create(user);
        }

        public void UpdateUser(User user)
        {
            Update(user);
        }

        public void DeleteUser(User user)
        {
            Delete(user);
        }

    }
}
