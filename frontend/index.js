import { backend } from "declarations/backend";

let modal;
let loadingSpinner;
let postsContainer;

document.addEventListener('DOMContentLoaded', async () => {
    modal = new bootstrap.Modal(document.getElementById('newPostModal'));
    loadingSpinner = document.getElementById('loadingSpinner');
    postsContainer = document.getElementById('postsContainer');

    document.getElementById('submitPost').addEventListener('click', createPost);
    
    await loadPosts();
});

async function loadPosts() {
    showLoading(true);
    try {
        const posts = await backend.getPosts();
        displayPosts(posts);
    } catch (error) {
        console.error('Error loading posts:', error);
        alert('Failed to load posts. Please try again later.');
    }
    showLoading(false);
}

function displayPosts(posts) {
    postsContainer.innerHTML = posts.map(post => `
        <div class="card mb-4">
            <div class="card-body">
                <h2 class="card-title">${post.title}</h2>
                <p class="text-muted">${new Date(Number(post.timestamp) / 1000000).toLocaleString()}</p>
                <p class="card-text">${formatContent(post.content)}</p>
            </div>
        </div>
    `).join('');
}

function formatContent(content) {
    return content.split('\n').map(paragraph => `<p>${paragraph}</p>`).join('');
}

async function createPost() {
    const titleInput = document.getElementById('postTitle');
    const contentInput = document.getElementById('postContent');
    
    const title = titleInput.value.trim();
    const content = contentInput.value.trim();
    
    if (!title || !content) {
        alert('Please fill in all fields');
        return;
    }

    showLoading(true);
    try {
        await backend.createPost(title, content);
        modal.hide();
        titleInput.value = '';
        contentInput.value = '';
        await loadPosts();
    } catch (error) {
        console.error('Error creating post:', error);
        alert('Failed to create post. Please try again.');
    }
    showLoading(false);
}

function showLoading(show) {
    loadingSpinner.classList.toggle('d-none', !show);
}
