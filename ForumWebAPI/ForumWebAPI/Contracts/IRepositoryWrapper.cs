using System;
using System.Collections.Generic;
using System.Text;

namespace Contracts
{
    public interface IRepositoryWrapper
    {
        IRoleRepository RoleRepository { get; }
        IUserRepository UserRepository { get; }
        IPostRepository PostRepository { get; }
        ICredentialRepository CredentialRepository { get; }
        ILikeRepository LikeRepository { get; }
        ITopicRepository TopicRepository { get; }
        IReplyRepository ReplyRepository { get; }

        void Save();
    }
}
