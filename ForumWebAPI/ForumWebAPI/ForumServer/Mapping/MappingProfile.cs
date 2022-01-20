using AutoMapper;
using Entities.Models;
using Entities.ModelsDTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ForumServer.Mapping 
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<User, UserGetDto>();
            CreateMap<UserPostDto, User>();
            CreateMap<UserPostPutDto, User>();

            CreateMap<Credential, CredentialGetDto>();
            CreateMap<CredentialPostDto, Credential>();
            CreateMap<CredentialPostPutDto, Credential>();

            CreateMap<Like, LikeGetDto>();
            CreateMap<LikePostPutDto, Like>();

            CreateMap<Post, PostGetDto>();
            CreateMap<PostPostPutDto, Post>();

            CreateMap<Role, RoleDto>();
            CreateMap<RoleDto, Role>();
            CreateMap<Role, RoleGetPutDto>();

            CreateMap<Topic, TopicGetDto>();
            CreateMap<TopicPostPutDto, Topic>();
        }
    }
}
