using System;
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
            ResponseDTO response = new ResponseDTO();
            try
            {
                response.Count = dbcontext.Database.ExecuteSqlCommand("sp_AddorUpdateUser @userId,@firstName,@lastName,@userName,@password,@role,@userStatus,@gender,@email,@country,@designation",
                            new SqlParameter("userId", objUser.UserId),
                            new SqlParameter("firstName", objUser.FirstName),
                            new SqlParameter("lastName", objUser.LastName),
                            new SqlParameter("userName", objUser.UserName ==null ? "" : objUser.UserName),
                            new SqlParameter("password", objUser.Password == null ? "" : objUser.Password),
                            new SqlParameter("role", objUser.Role),
                            new SqlParameter("userStatus",objUser.UserStatus),
                            new SqlParameter("gender", objUser.Gender == null ? "" : objUser.Gender),
                            new SqlParameter("email", objUser.Email),
                            new SqlParameter("country", objUser.Country),
                            new SqlParameter("designation", objUser.Designation ==null ? "" : objUser.Designation));
                if (response.Count > 0)
                {
                    response.IsSucess = true;
                }                
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
        public Category Category(string categorySlug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Category -Begin");
            Category objcategory = null;
            try
            {
                objcategory = dbcontext.Database.SqlQuery<Category>("sp_GetCategoryByCatSlug @categoryUrlSlug",
                            new SqlParameter("categoryUrlSlug", categorySlug)).FirstOrDefault();
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
        public Tag Tag(string tagSlug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tag -Begin");
            Tag objTag = null;
            try
            {
                objTag = dbcontext.Database.SqlQuery<Tag>("sp_GetTagByTagSlug @tagSlug",
                            new SqlParameter("@tagSlug", tagSlug)).FirstOrDefault();
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
        public Post Post(string urlslug,long? postId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Post -Begin");
            Post post = null;
            try
            {
                if (postId != null && postId > 0)
                    post = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByPostId @postId",
                                new SqlParameter("postId", postId)).FirstOrDefault();
                else
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

                    List<Comment> _lstComments = dbcontext.Database.SqlQuery<Comment>("sp_GetCommentsByPostId @postId",
                                    new SqlParameter("postId", post.PostId)).ToList();
                    if (_lstComments != null)
                        post.Comments = _lstComments;                  
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
        /// Gets all commets by postid
        /// </summary>
        /// <param name="postId"></param>
        /// <returns>Comments list</returns>
        public List<Comment> GetCommentsByPostId(long postId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Post -Begin");
            List<Comment> _lstComments = new List<Comment>();
            try
            {
                _lstComments = dbcontext.Database.SqlQuery<Comment>("sp_GetCommentsByPostId @postId",
                                     new SqlParameter("postId", postId)).ToList();

            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Post " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Post -End");
            return _lstComments;
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
                _lstTag = dbcontext.Database.SqlQuery<Tag>("sp_GetAllTags").OrderBy(x => x.TagName).OrderByDescending(x=>x.TagId).ToList();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Tags " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Tags - End");
            return _lstTag;
        }
        
        /// <summary>
        /// Saves comment added by user
        /// </summary>
        /// <param name="objComment"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO SaveComment(Comment objComment)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveComment - Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                int count = dbcontext.Database.ExecuteSqlCommand("sp_SaveComment @comment_Id,@comment_Content,@comment_Date,@comment_Author,@Comment_AuthorEmail,@Comment_PostId",
                                new SqlParameter("comment_Id", objComment.Comment_Id),
                                new SqlParameter("comment_Content", objComment.Comment_Content),
                                new SqlParameter("comment_Date", objComment.Comment_Date),
                                new SqlParameter("comment_Author", objComment.Comment_Author),
                                new SqlParameter("Comment_AuthorEmail", objComment.Comment_AuthorEmail),                                
                                new SqlParameter("Comment_PostId",objComment.Comment_PostId));
                if (count > 0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: SaveComment " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveComment - End");
            return response;
        }

        /// <summary>
        /// Gets the Reply for comment if exists
        /// </summary>
        /// <param name="commentId"></param>
        /// <returns></returns>
        public Reply GetReplyForComment(long commentId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetReplyForComment - Begin");
            Reply objReply = new Reply();
            try
            {
                objReply = dbcontext.Database.SqlQuery<Reply>("sp_GetReplyForComment @CommentId",
                            new SqlParameter("CommentId",commentId)).FirstOrDefault();      
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetReplyForComment " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetReplyForComment - End");
            return objReply;
        }

        #endregion Posts

        #region Account

        #region Posts

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
                
                response.Id = dbcontext.Database.SqlQuery<long>("sp_SavePostDetails @postId,@title,@postDescription,@postMeta,@postUrlSlug,@isPublished,@postedOn,@modifiedDate,@createdBy,@createdDate,@postStatus,@categoryId,@userId,@modifiedBy,@tagString",
                            new SqlParameter("postId", objPost.PostId),
                            new SqlParameter("title", objPost.Title),
                            new SqlParameter("postDescription", objPost.PostDescription),
                            new SqlParameter("postMeta", objPost.PostMeta),
                            new SqlParameter("postUrlSlug", objPost.PostUrlSlug),
                            new SqlParameter("isPublished", objPost.IsPublished),
                            new SqlParameter("postedOn", objPost.PostedOn != null ? objPost.PostedOn : (object)DBNull.Value),
                            new SqlParameter("modifiedDate", objPost.ModifiedDate != null ? objPost.ModifiedDate : (object)DBNull.Value),
                            new SqlParameter("createdBy", objPost.CreatedBy!=null ? objPost.CreatedBy:(object)DBNull.Value),
                            new SqlParameter("createdDate", objPost.CreatedDate != null ? objPost.CreatedDate : DateTime.Now),
                            new SqlParameter("postStatus", objPost.postStatus),
                            new SqlParameter("categoryId", objPost.CategoryId),
                            new SqlParameter("userId", objPost.UserId > 0 ? objPost.UserId:(object)DBNull.Value),
                            new SqlParameter("modifiedBy", objPost.ModifiedBy != null ? objPost.ModifiedBy : (object)DBNull.Value),
                            new SqlParameter("tagString", tagString)).Single();
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

        /// <summary>
        /// Gets post object by postib
        /// </summary>
        /// <param name="postId"></param>
        /// <returns>post</returns>
        public Post GetPostDetailsById(long postId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetPostDetailsById -Begin");
            Post objPost = null;
            try
            {
                objPost = dbcontext.Database.SqlQuery<Post>("sp_GetPostsByPostId @postId",
                                new SqlParameter("postId", postId)).FirstOrDefault();
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

        /// <summary>
        /// Deletes post by postid
        /// </summary>
        /// <param name="postId"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO deletePost(long postId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: deletePost -Begin");
            ResponseDTO response = new ResponseDTO();
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

        /// <summary>
        /// Publish the post by changing Ispublish column value to true
        /// </summary>
        /// <param name="postId"></param>
        /// <returns></returns>
        public ResponseDTO PublishPost(long postId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: PublishPost -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                response.Id = dbcontext.Database.ExecuteSqlCommand("sp_PublishPost @postId,@postedOn",
                                new SqlParameter("postId", postId),
                                new SqlParameter("postedOn",DateTime.Now));
                if (response.Id > 0)
                {
                    response.IsSucess = true;
                }                    
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: PublishPost " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: PublishPost -End");
            return response;
        }

        /// <summary>
        /// Gets the navigation for selected post 
        /// </summary>
        /// <param name="postId"></param>
        /// <returns></returns>
        public PostNavDetails GetNextAndPreviousPostIds(long postId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetNextAndPreviousPostIds -Begin");
            PostNavDetails objDetails = new PostNavDetails();
            try
            {
                objDetails = dbcontext.Database.SqlQuery<PostNavDetails>("sp_GetPreAndNextPosts @postId",
                            new SqlParameter("postId", postId)).FirstOrDefault();
            }
            catch(Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetNextAndPreviousPostIds " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetNextAndPreviousPostIds -Begin");
            return objDetails;
        }

        public ResponseDTO IsPostUrlSlugExists(string postUrlSlug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsPostUrlSlugExists -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                List<Post> _lstpost = dbcontext.Database.SqlQuery<Post>("sp_IsPostUrlSlugExists @postUrlSlug",
                                new SqlParameter("postUrlSlug", postUrlSlug)).ToList();
                if (_lstpost != null && _lstpost.Count > 0)
                {
                    response.IsSucess = true;
                }
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: IsPostUrlSlugExists " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsPostUrlSlugExists -End");
            return response;
        }

        #endregion Posts

        #region Users

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
        /// <summary>
        /// Delets user by userid
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO DeleteUser(long userId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteUser -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                int count = dbcontext.Database.ExecuteSqlCommand("sp_DeleteUser @userId",
                                new SqlParameter("userId", userId));
                if (count > 0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: DeleteUser " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteUser -Begin");
            return response;
        }

        #endregion Users

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

        #region Tags

        /// <summary>
        /// Saves new tag
        /// </summary>
        /// <param name="objTag"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO SaveTag(Tag objTag)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveTag -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                int count = dbcontext.Database.ExecuteSqlCommand("sp_AddorUpdateTag @tagId,@tagName,@tagUrlSlug,@tagDescription",
                            new SqlParameter("tagId", objTag.TagId),
                            new SqlParameter("tagName",objTag.TagName),
                            new SqlParameter("tagUrlSlug",objTag.TagUrlSlug),
                            new SqlParameter("tagDescription",objTag.TagDescription == null ? String.Empty : objTag.TagDescription));
                if (count > 0)
                    response.IsSucess = true;                
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: SaveTag " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveTag -End");
            return response;
        }
        /// <summary>
        /// Get Tag by tagid
        /// </summary>
        /// <param name="tagId"></param>
        /// <returns>Tag</returns>
        public Tag GetTagById(long tagId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetTagById -Begin");
            Tag objTag = null;
            try
            {
                objTag = dbcontext.Database.SqlQuery<Tag>("sp_GetTagByTagId @tagId",
                            new SqlParameter("tagId", tagId)).FirstOrDefault();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetTagById " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetTagById -End");
            return objTag;
        }
        /// <summary>
        /// Deletes Tag by tagid
        /// </summary>
        /// <param name="tagId"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO DeleteTag(long tagId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteTag -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                int count = dbcontext.Database.ExecuteSqlCommand("sp_DeleteTagByTagId @tagId",
                            new SqlParameter("tagId", tagId));
                if (count > 0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: DeleteTag " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteTag -End");
            return response;
        }        
        public ResponseDTO IsTagSlugExists(string tagSlug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsTagSlugExists -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                var objTag = dbcontext.Database.SqlQuery<Tag>("sp_GetTagByTagSlug @tagSlug",
                            new SqlParameter("tagSlug", tagSlug)).FirstOrDefault();
                if (objTag!=null && objTag.TagId>0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: IsTagSlugExists " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsTagSlugExists -End");
            return response;
        }
        #endregion Tags

        #region Categories

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
                _lstCategory = dbcontext.Database.SqlQuery<Category>("sp_GetAllCategories").OrderBy(x => x.CategoryName).ToList();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: Categories " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: Categories - End");
            return _lstCategory;
        }
        /// <summary>
        /// Saves or upates category
        /// </summary>
        /// <param name="objCategory"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO SaveCategory(Category objCategory)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveCategory - Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                int count = dbcontext.Database.ExecuteSqlCommand("sp_AddorUpdateCategory @categoryId,@categoryName,@categoryUrlSlug,@categoryDescription",
                            new SqlParameter("categoryId",objCategory.CategoryId),
                            new SqlParameter("categoryName",objCategory.CategoryName),
                            new SqlParameter("categoryUrlSlug",objCategory.CategoryUrlSlug),
                            new SqlParameter("categoryDescription",objCategory.CategoryDescription == null ? String.Empty : objCategory.CategoryDescription));
                if (count > 0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: SaveCategory " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveCategory - End");
            return response;
        }
        /// <summary>
        /// Get Category by category id
        /// </summary>
        /// <param name="categoryId"></param>
        /// <returns>Category</returns>
        public Category GetCategoryById(long categoryId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetCategoryById - Begin");
            Category objCategory = new Category();
            try
            {
                objCategory = dbcontext.Database.SqlQuery<Category>("sp_GetCategoryById @categoryId",
                            new SqlParameter("categoryId", categoryId)).FirstOrDefault();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetCategoryById " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetCategoryById - End");
            return objCategory;
        }
        /// <summary>
        /// Deletes category by category id
        /// </summary>
        /// <param name="categoryId"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO DeleteCategory(long categoryId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteCategory - Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                int count = dbcontext.Database.ExecuteSqlCommand("sp_DeleteCategoryById @categoryId",
                            new SqlParameter("categoryId", categoryId));
                if (count > 0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: DeleteCategory " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteCategory - End");
            return response;
        }
        /// <summary>
        /// Checks whether category slug exists
        /// </summary>
        /// <param name="categorySlug"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO IsCategorySlugExists(string categorySlug)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsCategorySlugExists -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                var objCategory = dbcontext.Database.SqlQuery<Category>(" sp_GetCategoryByCatSlug @categoryUrlSlug",
                            new SqlParameter("categoryUrlSlug", categorySlug)).FirstOrDefault();
                if (objCategory != null && objCategory.CategoryId > 0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: IsCategorySlugExists " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: IsCategorySlugExists -End");
            return response;
        }

        #endregion Categories

        #region Comments

        /// <summary>
        /// Get comments for all posts to display in Admin section
        /// </summary>
        /// <returns>Comments</returns>
        public List<Comment> GetAllComments()
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetAllComments -Begin");
            List<Comment> lstComments = new List<Comment>();
            try
            {
                lstComments = dbcontext.Database.SqlQuery<Comment>("sp_GetAllComments").ToList();                            
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetAllComments " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetAllComments -End");
            return lstComments;
        }

        /// <summary>
        /// Get Comment details by commentid
        /// </summary>
        /// <param name="commentId"></param>
        /// <returns>Comment</returns>
        public Comment GetCommentById(long commentId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetCommentById -Begin");
            Comment objComment = new Comment();
            try
            {
                objComment = dbcontext.Database.SqlQuery<Comment>("sp_GetCommentById").FirstOrDefault();
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: GetCommentById " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: GetCommentById -End");
            return objComment;
        }

        /// <summary>
        /// Deletes comment based on comment id
        /// </summary>
        /// <param name="commentId"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO DeleteComment(long commentId)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteComment -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                int count = dbcontext.Database.ExecuteSqlCommand("sp_DeleteComment @commentId",
                                new SqlParameter("commentId",commentId));
                if (count > 0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: DeleteComment " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: DeleteComment -End");
            return response;
        }

        /// <summary>
        /// Saves comment reply content
        /// </summary>
        /// <param name="objReply"></param>
        /// <returns>ResponseDTO</returns>
        public ResponseDTO SaveCommentReply(Reply objReply)
        {
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveCommentReply -Begin");
            ResponseDTO response = new ResponseDTO();
            try
            {
                int count = dbcontext.Database.ExecuteSqlCommand("sp_SaveComment_Reply @ReplyId,@ReplyContent,@ReplyDate,@ReplyAuthor,@ReplyCommentId",
                                new SqlParameter("ReplyId", objReply.ReplyId),
                                new SqlParameter("ReplyContent", objReply.Reply_Content),
                                new SqlParameter("ReplyDate", objReply.Reply_Date),
                                new SqlParameter("ReplyAuthor", objReply.Reply_Author),
                                new SqlParameter("ReplyCommentId", objReply.Reply_CoommentId));
                if (count > 0)
                    response.IsSucess = true;
                else
                    response.IsSucess = false;
            }
            catch (Exception ex)
            {
                logginghelper.Log(LoggingLevels.Error, "Class: " + classname + " :: SaveCommentReply " + ex);
            }
            logginghelper.Log(LoggingLevels.Info, "Class: " + classname + " :: SaveCommentReply -End");
            return response;
        }
        #endregion Comments       

        #endregion Account
    }
}
