Feature: Wordpress code scaffolding

  @theme
  Scenario: Scaffold a child theme
    Given a WP install

    When I run `wp scaffold child-theme zombieland --parent_theme=umbrella`
    Then it should run without errors
    
    When I run `wp theme path`
    Then it should run without errors
    And save STDOUT as {THEME_PATH}
    And the {THEME_PATH}/zombieland/style.css file should exist
    

  Scenario: Scaffold a Custom Taxonomy and Custom Post Type and write it to active theme
    Given a WP install

    When I run `wp scaffold taxonomy zombie-speed --theme`
    Then it should run without errors

    When I run `wp eval 'echo STYLESHEETPATH;'`
    Then it should run without errors
    And save STDOUT as {STYLESHEETPATH}
    And the {STYLESHEETPATH}/taxonomies/zombie-speed.php file should exist

    When I run `wp scaffold post-type zombie --theme`
    Then it should run without errors
    And the {STYLESHEETPATH}/post-types/zombie.php file should exist

  # Test for all flags but --label, --theme, --plugin and --raw
  Scenario: Scaffold a Custom Taxonomy and attach it to a CPT zombie that is prefixed and has a text domain
    Given a WP install

    When I run `wp scaffold taxonomy zombie-speed --post_types="prefix-zombie" --textdomain=zombieland`
    Then it should run without errors
    And STDOUT should contain:
      """
      __( 'Zombie speeds'
      """
    And STDOUT should contain:
      """
      array( 'prefix-zombie' )
      """
    And STDOUT should contain:
      """
      __( 'Zombie speeds', 'zombieland'
      """

  Scenario: Scaffold a Custom Taxonomy with label "Speed"
    Given a WP install

    When I run `wp scaffold taxonomy zombie-speed --label="Speed"`
    Then it should run without errors
    And STDOUT should contain:
        """
        __( 'Speed'
        """

  # Test for all flags but --label, --theme, --plugin and --raw
  Scenario: Scaffold a Custom Post Type
    Given a WP install

    When I run `wp scaffold post-type zombie --textdomain=zombieland`
    Then it should run without errors
    And STDOUT should contain:
      """
      __( 'Zombies'
      """
    And STDOUT should contain:
      """
      __( 'Zombies', 'zombieland'
      """

  Scenario: Scaffold a Custom Post Type with label
    Given a WP install

    When I run `wp scaffold post-type zombie --label="Brain eater"`
    Then it should run without errors
    And STDOUT should contain:
      """
      __( 'Brain eaters'
      """