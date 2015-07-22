redditCloneApp.controller('PostsCtrl', function($scope, $stateParams, postManager) {
  $scope.post = postManager.posts[$stateParams.id];

  $scope.addComment = function() {
    if ($scope.body === '') { return; }

    $scope.post.comments.push({
      body: $scope.body,
      author: 'user',
      upvotes: 0
    });

    $scope.body = '';
  };

  $scope.upvote = function(post) { post.upvotes += 1; };
  $scope.downvote = function(post) { post.upvotes -= 1; };
});
