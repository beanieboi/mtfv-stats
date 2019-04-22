//= require Chart.min

var initSearch = function(inputId) {
  var searchInput;
  var searchValue;
  var clearSearchButton;
  var tableRows;
  var expandableTables;

  // Credit David Walsh (https://davidwalsh.name/javascript-debounce-function)

  // Returns a function, that, as long as it continues to be invoked, will not
  // be triggered. The function will be called after it stops being called for
  // N milliseconds. If `immediate` is passed, trigger the function on the
  // leading edge, instead of the trailing.
  function debounce(func, wait, immediate) {
    var timeout;

    return function executedFunction() {
      var context = this;
      var args = arguments;

      var later = function() {
        timeout = null;
        if (!immediate) func.apply(context, args);
      };

      var callNow = immediate && !timeout;

      clearTimeout(timeout);

      timeout = setTimeout(later, wait);

      if (callNow) func.apply(context, args);
    };
  }

  function searchHandler(e) {
    search(e.srcElement.value.trim().toLowerCase());
  }

  function search(newSearchValue) {
    if (searchValue === newSearchValue) {
      return;
    }

    searchValue = newSearchValue;

    if (searchValue === "") {
      expandableTables.forEach(function(table) {
        table.classList.add("expandable-table--active");
      });

      tableRows.forEach(function(row) {
        row.classList.remove("hidden");
      });

      return;
    }

    tableRows.forEach(function(row) {
      row.classList.add("hidden");
      if (row.textContent.toLowerCase().includes(searchValue)) {
        row.classList.remove("hidden");
      }
    });

    expandableTables.forEach(function(table) {
      table.classList.remove("expandable-table--active");
    });
  }

  searchInput = document.getElementById(inputId);
  clearSearchButton = document.getElementById("clearSearch");
  tableRows = document.querySelectorAll("tbody tr");
  expandableTables = document.querySelectorAll(".expandable-table");

  if (searchInput) {
    searchInput.addEventListener("input", debounce(searchHandler, 500));

    if (clearSearchButton) {
      clearSearchButton.addEventListener("click", function() {
        searchInput.value = "";
        search(searchInput.value);
      });
    }
  } else {
    console.log("Search was not initialized. ID does not exist");
  }
};
