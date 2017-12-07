﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data;
using BlogEngine.Log;
using BlogEngine.Db;
using BlogEngine.DTO;
using System.Data.SqlClient;

namespace BlogEngine.DAL
{
    public class BlogEngineDAL
    {
        //changes done by Sridhar Thota Ji...

        public string classname = "BlogEngineDataAccess";
        LoggingHelper logginghelper = null;
        BlogEngineDbContext dbcontext = null;
        public BlogEngineDAL() : base()
        {
            logginghelper = new LoggingHelper();
            dbcontext = new BlogEngineDbContext();
        }

        #region User

        /// <summary>
        /// Returns all user details from database..
        /// </summary>
        /// <returns>User list</returns>
        public List<User> GetUserList()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetUserList -Begin");
            List<User> userlist = new List<User>();
            try
            {
                userlist = dbcontext.Database.SqlQuery<User>("sp_GetAllUserDetails").ToList();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetUserList " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetUserList -End");
            return userlist;
        }

        /// <summary>
        /// Returns current user based on username and password
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="Password"></param>
        /// <returns>USer</returns>
        public User GetCurrentUser(string userName,string Password)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetCurrentUser -Begin");
            User user = null;
            try
            {
                long userId = 0;
                user = dbcontext.Database.SqlQuery<User>("sp_GetCurrentUser @userId,@userName,@password",
                            new SqlParameter("userId",userId),
                            new SqlParameter("userName",userName),
                            new SqlParameter("password",Password)).FirstOrDefault();
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetCurrentUser " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetCurrentUser -End");
            return user;
        }

        public ResponseDTO SaveUser(User objUser)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveUser -Begin");
            ResponseDTO response = null;
            try
            {
                response.Id = dbcontext.Database.ExecuteSqlCommand("sp_GetCurrentUser @userId,@firstName,@lastName,@userName,@password,@role,@gender,@email,@country,@designation",
                            new SqlParameter("userId", objUser.UserId),
                            new SqlParameter("firstName", objUser.FirstName),
                            new SqlParameter("lastName", objUser.LastName),
                            new SqlParameter("userName",objUser.UserName),
                            new SqlParameter("password", objUser.Password),
                            new SqlParameter("role", objUser.Role),
                            new SqlParameter("gender", objUser.Gender),
                            new SqlParameter("email", objUser.Email),
                            new SqlParameter("country", objUser.Country),
                            new SqlParameter("designation", objUser.Designation));
                if (response.Id > 0)
                    response.IsSucess = true;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: SaveUser " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveUser -End");
            return response;
        }
        #endregion User

        #region Reusable Section

        /// <summary>
        /// returns post id for a posturlslug
        /// </summary>
        /// <param name="postUrlSlug"></param>
        /// <returns>postid</returns>
        public long GetPostIdByUrlSlug(string postUrlSlug)
        {
            long postId = 0;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostIdByUrlSlug - Begin");
            try
            {
                postId = dbcontext.Database.SqlQuery<long>("sp_GetPostIdByUrlSlug @postUrlSlug",
                            new SqlParameter("@postUrlSlug", postUrlSlug)).SingleOrDefault();
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetPostIdByUrlSlug " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostIdByUrlSlug - End");
            return postId;
        }

        /// <summary>
        /// Returns the post list based on categoryid and tags
        /// This method written for reusability
        /// </summary>
        /// <returns>post list</returns>
        public List<Post> GetTagAndCategoriesByPost(List<Post> _lstPosts)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetTagAndCategoriesByPost - Begin");
            try
            {
                foreach (var post in _lstPosts)
                {
                    Category objcategory = dbcontext.Database.SqlQuery<Category>("sp_GetCategoryById @categoryId",
                            new SqlParameter("categoryId", post.CategoryId)).FirstOrDefault();
                    if (objcategory != null)
                        post.Category = objcategory;

                    List<Tag> _lsttag = dbcontext.Database.SqlQuery<Tag>("sp_GetTagsByPostId @postId",
                            new SqlParameter("postId", post.PostId)).ToList();
                    if (_lsttag != null && _lsttag.Count > 0)
                        post.Tags = _lsttag;
                }
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetTagAndCategoriesByPost " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetTagAndCategoriesByPost - End");
            return _lstPosts;
        }

        public List<Tag> GetTagsByPostId(long postId)
        {
            List<Tag> _lsttag = null;
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetTagsByPostId - Begin");
            try
            {
                _lsttag = dbcontext.Database.SqlQuery<Tag>("sp_GetTagsByPostId @postId",
                            new SqlParameter("postId", postId)).ToList();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetTagsByPostId " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetTagsByPostId - End");
            return _lsttag;
        }

        #endregion Reusable Section

        #region Posts

        /// <summary>
        /// Returns posts based on page no & page size
        /// </summary>
        /// <param name="pageNo"></param>
        /// <param name="pageSize"></param>
        /// <returns>"Post List"</returns>
        public List<Post> Posts(int pageNo, int pageSize)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Posts -Begin");
            List<Post> _lstPosts = null;
            try
            {
                _lstPosts= dbcontext.Database.SqlQuery<Post>("sp_GetAllPosts").ToList();
                if (_lstPosts != null && _lstPosts.Count > 0)
                {
                    _lstPosts = _lstPosts.OrderByDescending(x => x.PostedOn).Where(x => x.IsPublished)
                                           .Skip(pageNo * pageSize).Take(pageSize).ToList();

                    _lstPosts = GetTagAndCategoriesByPost(_lstPosts);
                }                                             
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Posts " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Posts -End");
            return _lstPosts;
        }

        /// <summary>
        /// Method returns total posts count
        /// </summary>
        /// <returns>postcount</returns>
        public int TotalPosts()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: TotalPosts -Begin");
            int totalPostscount = 0;
            try
            {
                totalPostscount = dbcontext.Database.SqlQuery<Post>("sp_GetAllPosts").ToList().Where(x => x.IsPublished).Count();
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: TotalPosts " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: TotalPosts -End");
            return totalPostscount;
        }

        /// <summary>
        /// Returns posts belongs to category..
        /// </summary>
        /// <param name="categorySlug"></param>
        /// <param name="pageNo"></param>
        /// <param name="pageSize"></param>
        /// <returns>Posts List</returns>
        public List<Post> PostsForCategory(string categorySlug, int pageNo, int pageSize)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: PostsForCategory -Begin");
            List<Post> _lstPosts = null;
            try
            {
                _lstPosts = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByCategorySlug @categorySlug",
                            new SqlParameter("@categorySlug",categorySlug)).ToList();
                
                if (_lstPosts != null && _lstPosts.Count > 0)
                {
                    _lstPosts = _lstPosts.OrderByDescending(x => x.PostedOn).Where(x => x.IsPublished)
                                           .Skip(pageNo * pageSize).Take(pageSize).ToList();

                    _lstPosts=GetTagAndCategoriesByPost(_lstPosts);
                }
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: PostsForCategory " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: PostsForCategory -End");
            return _lstPosts;
        }

        /// <summary>
        /// Returns posts count in category
        /// </summary>
        /// <param name="categorySlug"></param>
        /// <returns>posts count</returns>
        public int TotalPostsForCategory(string categorySlug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: TotalPostsForCategory -Begin");
            int totalpostscount = 0;
            try
            {
                totalpostscount = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByCategorySlug @categorySlug",
                            new SqlParameter("categorySlug", categorySlug)).ToList().Where(x => x.IsPublished).Count();
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: TotalPostsForCategory " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: TotalPostsForCategory -End");
            return totalpostscount;
        }

        /// <summary>
        /// Gets Category by CategoryUrlSlug
        /// </summary>
        /// <param name="categorySlug"></param>
        /// <returns> Category</returns>
        public Category Category(string categoryId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Category -Begin");
            Category objcategory = null;
            try
            {
                objcategory = dbcontext.Database.SqlQuery<Category>("sp_GetCategoryById @categoryId",
                            new SqlParameter("categoryId", Convert.ToInt64(categoryId))).FirstOrDefault();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Category " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Category -End");
            return objcategory;
        }

        /// <summary>
        /// Returns posts based on Tag
        /// </summary>
        /// <param name="tagSlug"></param>
        /// <param name="pageNo"></param>
        /// <param name="pageSize"></param>
        /// <returns>post list</returns>
        public List<Post> PostsForTag(string tagSlug, int pageNo, int pageSize)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: PostsForTag -Begin");
            List<Post> _lstPosts = null;
            try
            {
                _lstPosts = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByTagSlug @tagSlug",
                            new SqlParameter("tagSlug", tagSlug)).ToList();

                if (_lstPosts != null && _lstPosts.Count > 0)
                {
                    _lstPosts = _lstPosts.OrderByDescending(x => x.PostedOn).Where(x => x.IsPublished)
                                           .Skip(pageNo * pageSize).Take(pageSize).ToList();

                    _lstPosts = GetTagAndCategoriesByPost(_lstPosts);
                }
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: PostsForTag " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: PostsForTag -End");
            return _lstPosts;
        }

        /// <summary>
        /// Returns count of post for tag
        /// </summary>
        /// <param name="tagSlug"></param>
        /// <returns>posts count</returns>
        public int TotalPostForTag(string tagSlug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: TotalPostForTag -Begin");
            int totalpostscount = 0;
            try
            {
                totalpostscount = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByTagSlug @tagSlug",
                            new SqlParameter("tagSlug",tagSlug)).ToList().Where(x => x.IsPublished).Count();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: TotalPostForTag " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: TotalPostForTag -End");
            return totalpostscount;
        }

        /// <summary>
        /// Reurns Tag by tagurlSlug
        /// </summary>
        /// <param name="tagSlug"></param>
        /// <returns>Tag</returns>
        public Tag Tag(string tagId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tag -Begin");
            Tag objTag = null;
            try
            {
                objTag = dbcontext.Database.SqlQuery<Tag>("sp_GetTagByTagId @tagId",
                            new SqlParameter("tagId", Convert.ToInt64(tagId))).FirstOrDefault();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Tag " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tag -End");
            return objTag;
        }

        /// <summary>
        /// Returns the searched posts
        /// </summary>
        /// <param name="search"></param>
        /// <param name="pageNo"></param>
        /// <param name="pageSize"></param>
        /// <returns>posts list</returns>
        public List<Post> PostsForSearch(string search,int pageNo,int pageSize)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: PostsForSearch -Begin");
            List<Post> _lstPosts = null;
            try
            {
                _lstPosts = dbcontext.Database.SqlQuery<Post>("sp_GetPostsBySearch @searchText",
                            new SqlParameter("searchText", search)).ToList();
                if (_lstPosts != null && _lstPosts.Count > 0)
                {
                    _lstPosts = _lstPosts.OrderByDescending(x => x.PostedOn).Where(x => x.IsPublished)
                                           .Skip(pageNo * pageSize).Take(pageSize).ToList();

                    _lstPosts = GetTagAndCategoriesByPost(_lstPosts);
                }
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: PostsForSearch " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: PostsForSearch -End");
            return _lstPosts;
        }

        /// <summary>
        /// Returns posts count of searched posts
        /// </summary>
        /// <param name="search"></param>
        /// <returns>int</returns>
        public int TotalPostsForSearch(string search)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: TotalPostsForSearch -Begin");
            int totalpostscount = 0;
            try
            {
                totalpostscount = dbcontext.Database.SqlQuery<Post>("sp_GetPostsBySearch @searchText",
                            new SqlParameter("searchText", search)).ToList().Where(x=>x.IsPublished).Count();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: TotalPostsForSearch " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: TotalPostsForSearch -End");
            return totalpostscount;
        }

        /// <summary>
        /// Returns single post based on year,month and title of post
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="titleSlug"></param>
        /// <returns>Post</returns>
        public Post Post(string urlslug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Post -Begin");
            Post post = null;
            try
            {
                post = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByPostUrlSlug @postUrlSlug",
                            new SqlParameter("@postUrlSlug", urlslug)).FirstOrDefault();
                if (post != null)
                {
                    Category objcategory = dbcontext.Database.SqlQuery<Category>("sp_GetCategoryById @categoryId",
                            new SqlParameter("categoryId", post.CategoryId)).FirstOrDefault();
                    if (objcategory != null)
                        post.Category = objcategory;

                    List<Tag> _lsttag = dbcontext.Database.SqlQuery<Tag>("sp_GetTagsByPostId @postId",
                            new SqlParameter("postId", post.PostId)).ToList();
                    if (_lsttag != null && _lsttag.Count > 0)
                        post.Tags = _lsttag;
                }
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Post " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Post -End");
            return post;
        }

        /// <summary>
        /// Returns all categories
        /// </summary>
        /// <returns>Category List</returns>
        public List<Category> Categories()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Categories - Begin");
            List<Category> _lstCategory = null;
            try
            {
                _lstCategory = dbcontext.Database.SqlQuery<Category>("sp_GetAllCategories").OrderBy(x=>x.CategoryName).ToList();
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Categories " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Categories - End");
            return _lstCategory;
        }

        /// <summary>
        /// Returns all tags to display on sidebar
        /// </summary>
        /// <returns>Tag List</returns>
        public List<Tag> Tags()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tags - Begin");
            List<Tag> _lstTag = null;
            try
            {
                _lstTag = dbcontext.Database.SqlQuery<Tag>("sp_GetAllTags").OrderBy(x => x.TagName).ToList();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Tags " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tags - End");
            return _lstTag;
        }
        #endregion Posts

        #region Account

        /// <summary>
        /// Returns posts belongs to User(id)
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns>Posts List</returns>
        public List<Post> GetPostsByUserId(long UserId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostsByUserId -Begin");
            List<Post> _lstPosts = null;
            try
            {
                _lstPosts = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByUserId @userId",
                            new SqlParameter("userId",UserId)).OrderByDescending(x=>x.PostedOn).ToList();
                if (_lstPosts != null && _lstPosts.Count > 0)
                    _lstPosts = GetTagAndCategoriesByPost(_lstPosts);

            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetPostsByUserId " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostsByUserId -End");
            return _lstPosts;
        }

        /// <summary>
        /// Returns user details by userid
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns>User</returns>
        public User GetUserDetailsById(long UserId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetUserDetailsById -Begin");
            User objUser = null;
            try
            {
                objUser = dbcontext.Database.SqlQuery<User>("sp_GetCurrentUser @userId",
                                new SqlParameter("userId", UserId)).FirstOrDefault();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetUserDetailsById " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetUserDetailsById -End");
            return objUser;
        }

        #region Dropdowns
        /// <summary>
        /// Returns all roles to populate roles dropdowns
        /// </summary>
        /// <returns>Roles list</returns>
        public List<Role> GetRoleDropdowns()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetUserDetailsById -Begin");
            List<Role> _lstRoles = null;
            try
            {
                _lstRoles = dbcontext.Database.SqlQuery<Role>("sp_GetAllRoles").ToList();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetUserDetailsById " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetUserDetailsById -End");
            return _lstRoles;
        }

        /// <summary>
        /// Gets all countries data
        /// </summary>
        /// <returns>Country List</returns>
        public List<Country> GetCountryDropdowns()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetCountryDropdowns -Begin");
            List<Country> _lstCountries = null;
            try
            {
                _lstCountries = dbcontext.Database.SqlQuery<Country>("sp_GetAllCountries").ToList();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetCountryDropdowns " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetCountryDropdowns -End");
            return _lstCountries;
        }

        #endregion Dropdowns

        /// <summary>
        /// Returns post id of after saving post details
        /// </summary>
        /// <param name="objPost"></param>
        /// <returns>long</returns>
        public ResponseDTO SavePost(Post objPost)
        {
            ResponseDTO response = new ResponseDTO();
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SavePost -Begin");
            try
            {
                string tagString = string.Empty;
                if (objPost.Tags != null || objPost.Tags.Count > 0)
                {
                    foreach (var tag in objPost.Tags)
                    {
                        tagString += tag.TagId + ",";                        
                    }
                    tagString = tagString.TrimEnd(',');
                } 
                
                response.Id = dbcontext.Database.ExecuteSqlCommand("sp_SavePostDetails @postId,@title,@postDescription,@postMeta,@postUrlSlug,@isPublished,@postedOn,@modifiedDate,@createdBy,@createdDate,@postStatus,@categoryId,@userId,@modifiedBy,@tagString",
                            new SqlParameter("postId",objPost.PostId),
                            new SqlParameter("title",objPost.Title),
                            new SqlParameter("postDescription",objPost.PostDescription),
                            new SqlParameter("postMeta",objPost.PostMeta),
                            new SqlParameter("postUrlSlug",objPost.PostUrlSlug),
                            new SqlParameter("isPublished", objPost.IsPublished),
                            new SqlParameter("postedOn", objPost.PostedOn!=null ? objPost.PostedOn : (object)DBNull.Value),
                            new SqlParameter("modifiedDate", objPost.ModifiedDate != null ? objPost.PostedOn : (object)DBNull.Value),
                            new SqlParameter("createdBy", objPost.CreatedBy),
                            new SqlParameter("createdDate", objPost.CreatedDate!=null ? objPost.CreatedDate:DateTime.Now),
                            new SqlParameter("postStatus", objPost.postStatus),
                            new SqlParameter("categoryId", objPost.CategoryId),
                            new SqlParameter("userId", objPost.UserId),
                            new SqlParameter("modifiedBy", objPost.ModifiedBy!=null ? objPost.ModifiedBy:(object)DBNull.Value),
                            new SqlParameter("tagString", tagString));
                if (response.Id > 0)
                    response.IsSucess = true;
            }
            catch (Exception ex)
            {
                response.IsSucess = false;
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: SavePost " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SavePost -Begin");
            return response;
        }

        public Post GetPostDetailsById(long postId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostDetailsById -Begin");
            Post objPost = null;
            try
            {
                objPost = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByPostId @postId",
                                new SqlParameter("postId",postId)).FirstOrDefault();
                var tags = GetTagsByPostId(postId);
                if (tags != null)
                    objPost.Tags = tags;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetPostDetailsById " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostDetailsById -End");
            return objPost;
        }
        public ResponseDTO deletePost(long postId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: deletePost -Begin");
            ResponseDTO response = null;
            try
            {
                response.Id = dbcontext.Database.ExecuteSqlCommand("sp_DeletePost @postId",
                                new SqlParameter("postId", postId));
                if (response.Id > 0)
                    response.IsSucess = true;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: deletePost " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: deletePost -End");
            return response;
        }
        #endregion Account
    }
}
