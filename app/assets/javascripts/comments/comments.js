redditCloneApp.factory('commentService', function($http) {
  var service = {};

  service.get = function(comment_id) {
    return $http.get('/comments/' + comment_id + '.json').then(function(response) {
      return response.data;
    });
  };

  service.addComment = function(parent_comment_id, comment) {
    return $http.post('/comments/' + parent_comment_id + '/comments.json', comment);
  };

  service.upvote = function(comment) {
    return $http.put('/comments/' + comment.id +  '/upvote.json').success(function(data) {
      comment.upvotes = data.upvotes;
    });
  };

  service.downvote = function(comment) {
    return $http.put('/comments/' + comment.id +  '/downvote.json').success(function(data) {
      comment.upvotes = data.upvotes;
    });
  };

   return service;
});
