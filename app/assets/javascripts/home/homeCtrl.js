redditCloneApp.controller('HomeCtrl', function($scope, postManager){
  $scope.posts = postManager.posts;

  var clearForm = function() {
    $scope.title = '';
    $scope.link = '';
  };

  var titleBlank = function() {
    return ($scope.title === '' || $scope.title === undefined) ? true : false
  };

  $scope.addPost = function() {
    if (titleBlank()) { return; };

    $scope.posts.push({
      title: $scope.title,
      link: $scope.link,
      upvotes: 0,
      comments: [
        { author: 'Joe', body: 'Cool post!', upvotes: 0 },
        { author: 'Bob', body: 'Great idea but everything is wrong!', upvotes: 0 }
      ]
    });
    clearForm();
  };

  $scope.upvote = function(post) { post.upvotes += 1; };
  $scope.downvote = function(post) { post.upvotes -= 1; };
});

