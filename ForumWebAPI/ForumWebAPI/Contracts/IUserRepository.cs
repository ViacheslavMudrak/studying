using Entities.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Contracts
{
    public interface IUserRepository : IRepositoryBase<User>
    {
        IEnumerable<User> UsersByRoleId(int roleId);

        // HttpGet
        IEnumerable<User> GetAllUsers();
        User GetUserById(int id);

        // HttpPost
        void CreateUser(User user);

        // HttpPut
        void UpdateUser(User user);

        // HttpDelete
        void DeleteUser(User user);
    }
}
