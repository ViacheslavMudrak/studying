using Contracts;
using Entities;
using Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository
{
    public class CredentialRepository : RepositoryBase<Credential>, ICredentialRepository
    {
        public CredentialRepository(RepositoryContext repositoryContext) 
            : base(repositoryContext)
        {
        }

        public IEnumerable<Credential> GetAllCredentials()
        {
            return FindAll().ToList();
        }

        public Credential GetCredentialByUserId(int id)
        {
            return FindByCondition(c => c.UserId.Equals(id)).FirstOrDefault();
        }

        public void CreateCredential(Credential credential)
        {
            Create(credential);
        }

        public void UpdateCredential(Credential credential)
        {
            Update(credential);
        }

        public void DeleteCredential(Credential credential)
        {
            Delete(credential);
        }

    }
}
