using Entities.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Contracts
{
    public interface IReplyRepository : IRepositoryBase<Reply>
    {
        IEnumerable<Reply> RepiesByPostId(int postId);
    }
}
