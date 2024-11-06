import Bool "mo:base/Bool";

import Time "mo:base/Time";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Buffer "mo:base/Buffer";

actor {
    public type BlogPost = {
        id: Nat;
        title: Text;
        content: Text;
        timestamp: Int;
    };

    stable var posts : [BlogPost] = [];
    stable var nextId : Nat = 0;
    
    // Initialize with default content
    private func initialize() {
        if (posts.size() == 0) {
            let initialPosts = [
                {
                    id = 0;
                    title = "What is Platform Operations?";
                    content = "Platform Operations (Platform Ops) is a critical function in modern technology organizations that focuses on managing and maintaining the infrastructure and platforms that support application development and deployment.\n\nPlatform Ops teams are responsible for creating, maintaining, and optimizing the technical foundation that enables development teams to build, deploy, and run applications efficiently.";
                    timestamp = Time.now();
                },
                {
                    id = 1;
                    title = "Core Responsibilities of Platform Operations";
                    content = "1. Infrastructure Management: Maintaining cloud infrastructure, servers, and networking components\n\n2. Platform Development: Building and maintaining development and deployment platforms\n\n3. Automation: Creating and maintaining CI/CD pipelines and automation tools\n\n4. Security: Implementing platform-level security measures and compliance\n\n5. Monitoring: Setting up monitoring, alerting, and observability solutions\n\n6. Performance Optimization: Ensuring platform efficiency and scalability\n\n7. Documentation: Maintaining technical documentation and platform guidelines";
                    timestamp = Time.now();
                },
                {
                    id = 2;
                    title = "Key Skills in Platform Operations";
                    content = "Platform Operations professionals typically need expertise in:\n\n- Cloud Platforms (AWS, Azure, GCP)\n- Infrastructure as Code (Terraform, CloudFormation)\n- Container Orchestration (Kubernetes)\n- CI/CD Tools (Jenkins, GitLab)\n- Scripting and Automation\n- Monitoring Tools\n- Security Best Practices\n- Problem-Solving and Incident Response";
                    timestamp = Time.now();
                }
            ];
            
            posts := initialPosts;
            nextId := 3;
        };
    };

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

    public query func getPosts() : async [BlogPost] {
        if (posts.size() == 0) {
            initialize();
        };
        return Array.reverse(posts);
    };

    public query func getPost(id: Nat) : async ?BlogPost {
        Array.find(posts, func (post: BlogPost) : Bool { post.id == id })
    };

    public func deletePost(id: Nat) : async Bool {
        let tempPosts = Array.filter(posts, func (post: BlogPost) : Bool { post.id != id });
        if (tempPosts.size() != posts.size()) {
            posts := tempPosts;
            return true;
        };
        return false;
    };
}
