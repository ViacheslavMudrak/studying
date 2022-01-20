using Contracts;
using Entities;
using Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Repository
{
    public class ReplyRepostitory : RepositoryBase<Reply>, IReplyRepository
    {
        public ReplyRepostitory(RepositoryContext repositoryContext) 
            : base(repositoryContext)
        {
        }

        public IEnumerable<Reply> RepiesByPostId(int postId)
        {
            return FindByCondition(r => r.BasePostId.Equals(postId)).ToList();
        }
    }
}
