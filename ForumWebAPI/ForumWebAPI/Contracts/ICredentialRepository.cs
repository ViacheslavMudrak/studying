using Entities.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Contracts
{
    public interface ICredentialRepository : IRepositoryBase<Credential>
    {
        // HttpGet
        IEnumerable<Credential> GetAllCredentials();
        Credential GetCredentialByUserId(int id);

        // HttpPost
        void CreateCredential(Credential credential);

        // HttpPut
        void UpdateCredential(Credential credential);

        // HttpDelete
        void DeleteCredential(Credential credential);
    }
}
