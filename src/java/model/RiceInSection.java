package model;

import lombok.Data;

@Data
public class RiceInSection {
    private int riceSectionId;
    private int riceId;
    private int sectionId;
    private int quantity;
}
