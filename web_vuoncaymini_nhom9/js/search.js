function clearSearchBox() {
    let searchBox = document.getElementById('searchBox');
    if (searchBox.value === 'Tìm kiếm') {
        searchBox.value = '';
    }
}

function resetSearchBox() {
    let searchBox = document.getElementById('searchBox');
    if (searchBox.value === '') {
        searchBox.value = 'Tìm kiếm';
    }
}

function checkSearch() {
    let searchBox = document.getElementById('searchBox');
    let query = searchBox.value.trim();
    
    if (query === '' || query === 'Tìm kiếm') {
        alert('Vui lòng nhập từ khóa tìm kiếm!');
        return false;
    }

    // Điều hướng đến search.php với tham số query
    const encodedQuery = encodeURIComponent(query);
    const searchUrl = `../public/search.php?query=${encodedQuery}`;
    console.log('Navigating to:', searchUrl); // Ghi log để kiểm tra
    window.location.href = searchUrl;
    return false; // Ngăn form submit mặc định
}

// Kiểm tra file có tải không
console.log('search.js loaded successfully');