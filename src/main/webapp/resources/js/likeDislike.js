function sendLikeDislike(postId, action) {
    // action will be 'like' or 'dislike'
    $.ajax({
        type: "POST",
        url: "/api/posts/" + postId + "/" + action,
        success: function(response) {
            // Assuming the response contains the updated like and dislike counts
            // You'll need to adjust this based on your server's response structure
            $("#like-count-" + postId).text(response.likeCount);
            $("#dislike-count-" + postId).text(response.dislikeCount);
        },
        error: function(error) {
            console.error("Error sending " + action + ":", error);
            // Handle errors, e.g., show an alert to the user
        }
    });
}

$(document).ready(function() {
    // Attach click handlers to like and dislike buttons
    // Assuming your like buttons have a class 'like-button' and dislike buttons 'dislike-button'
    // And they have data attributes for the post ID, e.g., data-post-id="123"

    $(".like-button").on("click", function() {
        var postId = $(this).data("post-id");
        sendLikeDislike(postId, 'like');
    });

    $(".dislike-button").on("click", function() {
        var postId = $(this).data("post-id");
        sendLikeDislike(postId, 'dislike');
    });
});