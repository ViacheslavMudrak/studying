using Contracts;
using Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace Repository
{
    public class RepositoryWrapper : IRepositoryWrapper
    {
        private RepositoryContext _repositoryContext;
        private IRoleRepository _roleRepository;
        private IUserRepository _userRepository;
        private IPostRepository _postRepository;
        private ICredentialRepository _credentialRepository;
        private ILikeRepository _likeRepository;
        private ITopicRepository _topicRepository;
        private IReplyRepository _replyRepository;

        public RepositoryWrapper(RepositoryContext repositoryContext)
        {
            _repositoryContext = repositoryContext;
        }

        public IRoleRepository RoleRepository
        {
            get
            {
                if (_roleRepository == null)
                    _roleRepository = new RoleRepository(_repositoryContext);

                return _roleRepository;
            }
        }

        public IUserRepository UserRepository
        {
            get
            {
                if (_userRepository == null)
                    _userRepository = new UserRepository(_repositoryContext);

                return _userRepository;
            }
        }

        public IPostRepository PostRepository
        {
            get
            {
                if (_postRepository == null)
                    _postRepository = new PostRepository(_repositoryContext);

                return _postRepository;
            }
        }

        public ICredentialRepository CredentialRepository
        {
            get
            {
                if (_credentialRepository == null)
                    _credentialRepository = new CredentialRepository(_repositoryContext);

                return _credentialRepository;
            }
        }

        public ILikeRepository LikeRepository
        {
            get
            {
                if (_likeRepository == null)
                    _likeRepository = new LikeRepository(_repositoryContext);

                return _likeRepository;
            }
        }

        public ITopicRepository TopicRepository
        {
            get
            {
                if (_topicRepository == null)
                    _topicRepository = new TopicRepository(_repositoryContext);

                return _topicRepository;
            }
        }

        public IReplyRepository ReplyRepository
        {
            get
            {
                if (_replyRepository == null)
                    _replyRepository = new ReplyRepostitory(_repositoryContext);

                return _replyRepository;
            }
        }

        public void Save()
        {
            _repositoryContext.SaveChanges();
        }
    }
}
