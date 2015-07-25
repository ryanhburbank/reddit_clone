redditCloneApp.factory('postService', function($http){
  var service = { posts: [] };

  service.index = function() {
    return $http.get('/posts.json').success(function(data){
      angular.copy(data, service.posts);
    });
  };

  service.get = function(id) {
    return $http.get('/posts/' + id + '.json').then(function(response) {
      return response.data;
    });
  };

  service.create = function(post) {
    return $http.post('/posts.json', post).success(function(data) {
      service.posts.push(data);
    });
  };

  service.upvote = function(post) {
    return $http.put('/posts/' + post.id + '/upvote.json').success(function(data) {
      post.upvotes = data.upvotes;
    });
  };

  service.downvote = function(post) {
    return $http.put('/posts/' + post.id + '/downvote.json').success(function(data) {
      post.upvotes = data.upvotes;
    });
  }

  service.addComment = function(id, comment) {
    return $http.post('/posts/' + id + '/comments.json', comment);
  };

  return service;
});

