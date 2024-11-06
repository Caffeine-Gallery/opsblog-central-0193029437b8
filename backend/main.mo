import Bool "mo:base/Bool";

import Time "mo:base/Time";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Buffer "mo:base/Buffer";

actor {
    // Blog post type definition
    public type BlogPost = {
        id: Nat;
        title: Text;
        content: Text;
        timestamp: Int;
    };

    stable var posts : [BlogPost] = [];
    stable var nextId : Nat = 0;

    // Create a new blog post
    public func createPost(title: Text, content: Text) : async BlogPost {
        let post : BlogPost = {
            id = nextId;
            title = title;
            content = content;
            timestamp = Time.now();
        };
        
        nextId += 1;
        posts := Array.append(posts, [post]);
        return post;
    };

    // Get all blog posts
    public query func getPosts() : async [BlogPost] {
        return Array.reverse(posts);
    };

    // Get a specific post by ID
    public query func getPost(id: Nat) : async ?BlogPost {
        Array.find(posts, func (post: BlogPost) : Bool { post.id == id })
    };

    // Delete a post
    public func deletePost(id: Nat) : async Bool {
        let tempPosts = Array.filter(posts, func (post: BlogPost) : Bool { post.id != id });
        if (tempPosts.size() != posts.size()) {
            posts := tempPosts;
            return true;
        };
        return false;
    };
}
